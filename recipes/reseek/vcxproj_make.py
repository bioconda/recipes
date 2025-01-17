#!/usr/bin/env python

import argparse
import os
import sys

Usage = (
    "Convert Visual Studio .vcxproj file in current directory to Makefile and run make."
)

AP = argparse.ArgumentParser(description=Usage)

# Value opts
AP.add_argument(
    "--std",
    required=False,
    help="C++ standard option for GCC, e.g. c++11 or c++17 (default none)",
)
AP.add_argument(
    "--cppcompiler",
    required=False,
    default="g++",
    help="C++ compiler command name default g++)",
)
AP.add_argument(
    "--ccompiler",
    required=False,
    default="gcc",
    help="C++ compiler command name default gcc)",
)

# Flag opts
AP.add_argument("--debug", required=False, action="store_true", help="Debug build")
AP.add_argument("--openmp", required=False, action="store_true", help="Requires OMP")
AP.add_argument(
    "--pthread", required=False, action="store_true", help="Requires pthread"
)
AP.add_argument("--lrt", required=False, action="store_true", help="Requires lrt")
AP.add_argument(
    "--symbols",
    required=False,
    action="store_true",
    help="Debug symbols (default if --debug)",
)
AP.add_argument(
    "--nostrip",
    required=False,
    action="store_true",
    help="Don't strip symbols (default if --debug or --symbols)",
)

Args = AP.parse_args()
debug = Args.debug
std = Args.std
cppcompiler = Args.cppcompiler
ccompiler = Args.ccompiler
nostrip = debug or Args.symbols
symbols = debug or Args.symbols

ProjFileName = None
HdrNames = []
for FileName in os.listdir("."):
    if FileName.endswith(".vcxproj"):
        ProjFileName = FileName
    elif FileName.endswith(".h"):
        HdrNames.append(FileName)
if ProjFileName is None:
    sys.stderr.write("\nProject file not found in current directory\n")
    sys.exit(1)

binary = ProjFileName.replace(".vcxproj", "")
sys.stderr.write("binary=" + binary + "\n")

compiler_opts = " -ffast-math -march=generic"
linker_opts = " -ffast-math -march=generic"

if std:
    compiler_opts += " --std=" + std

if debug:
    compiler_opts += " -O0 -DDEBUG"
    linker_opts += " -O0"
else:
    compiler_opts += " -O3 -DNDEBUG"
    linker_opts += " -O3"

if symbols:
    compiler_opts += " -g3"
    linker_opts += " -g3"

if Args.openmp:
    compiler_opts += " -fopenmp"
    linker_opts += " -fopenmp"

if Args.pthread:
    compiler_opts += " -pthread"
    linker_opts += " -lpthread"

rc = os.system(r"rm -rf o/ ../bin/%s*" % binary)
if rc != 0:
    sys.stderr.write("\n\nERROR -- failed to clean\n\n")
    sys.exit(1)
sys.stderr.write("clean done.\n")

OBJDIR = "o"
BINDIR = "../bin"

Fields = ProjFileName.split("/")
n = len(Fields)
Name = Fields[n - 1]
Fields = Name.split(".")
binary = Fields[0]

CXXNames = []
CNames = []
with open(ProjFileName) as File:
    for Line in File:
        Line = Line.strip()
        Line = Line.replace('"', "")
        Line = Line.replace(" ", "")
        # <ClCompile Include="betadiv.cpp" />
        if Line.startswith("<ClCompileInclude"):
            Fields = Line.split("=")
            if len(Fields) != 2:
                continue
            FileName = Fields[1]
            FileName = FileName.replace("/>", "")
            if FileName.endswith(".cpp"):
                FileName = FileName.replace(".cpp", "")
                CXXNames.append(FileName)
            elif FileName.endswith(".c"):
                FileName = FileName.replace(".c", "")
                CNames.append(FileName)

assert len(CXXNames) > 0 or len(CNames) > 0

with open("Makefile", "w") as f:

    def Out(s):
        print(s, file=f)

    BINPATH = "$(BINDIR)/%s" % (binary)

    Out("######################################################")
    Out("# Makefile is generated by " + sys.argv[0])
    Out("# Don't edit the Makefile -- update the python script")
    Out("######################################################")
    Out("")
    Out("BINDIR := %s" % BINDIR)
    Out("OBJDIR := %s" % OBJDIR)
    Out("BINPATH := %s" % BINPATH)

    if CNames:
        Out("")
        Out("CC = " + ccompiler)
        Out("CFLAGS := $(CFLAGS) " + compiler_opts)

    if CXXNames:
        Out("")
        Out("CXX = " + cppcompiler)
        Out("CXXFLAGS := $(CFLAGS) " + compiler_opts)

    Out("")
    Out("UNAME_S := $(shell uname -s)")
    Out("LDFLAGS := $(LDFLAGS) " + linker_opts)
    Out("ifeq ($(UNAME_S),Linux)")
    Out("    LDFLAGS += -static")
    Out("endif")

    Out("")
    Out("HDRS = \\")
    for Name in sorted(HdrNames):
        Out("  %s \\" % Name)

    Out("")
    Out("OBJS = \\")
    for Name in CXXNames:
        Out("  $(OBJDIR)/%s.o \\" % (Name))

    for Name in CNames:
        Out("  $(OBJDIR)/%s.o \\" % (Name))

    Out("")
    Out(".PHONY: clean")

    Out("")
    Out("$(BINPATH) : $(BINDIR)/ $(OBJDIR)/ $(OBJS)")

    if len(CXXNames) > 0:
        Cmd = "\t$(CXX) $(LDFLAGS) $(OBJS) -o $(BINPATH)"
    else:
        Cmd = "\t%(CC) $(LDFLAGS) $(OBJS) -o $(BINPATH)"

    if Args.lrt:
        Cmd += " -lrt"
    Out(Cmd)

    if not nostrip:
        Out("	strip $(BINPATH)")

    Out("")
    Out("$(OBJDIR)/ :")
    Out("	mkdir -p $(OBJDIR)/")

    Out("")
    Out("$(BINDIR)/ :")
    Out("	mkdir -p $(BINDIR)/")

    if CNames:
        Out("")
        Out("$(OBJDIR)/%.o : %.c $(HDRS)")
        Out("	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<")

    if CXXNames:
        Out("")
        Out("$(OBJDIR)/%.o : %.cpp $(HDRS)")
        Out("	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<")

sys.stderr.write("Makefile done.\n")

rc = os.system("make")
if rc != 0:
    sys.stderr.write("\n\nERROR -- make failed\n\n")
    sys.exit(1)
sys.stderr.write("make done.\n")
