CXX := `root-config --cxx`
ROOTCLING=rootcling
MARCH := `root-config --arch`
LD:=$(CXX)
SRC=./src/

ANYOPTION=$(SRC)/anyoption.cpp

UNAME := $(shell uname)

CFLAGS += $(shell root-config --cflags --glibs) -g -fPIC -pthread -I$(ROOTSYS)/include
OPTFLAGS += -O3

default: all

all: raw_clusterize calibration AMS_convert

.PHONY: raw_viewer

AMS_convert: ./src/AMS_convert.cxx
	$(CXX) -o$@ $< $(CFLAGS) $(OPTFLAGS) $(ANYOPTION)

raw_clusterize: ./src/raw_clusterize.cxx
	$(CXX) -o$@ $< $(CFLAGS) $(OPTFLAGS) $(ANYOPTION)

calibration: ./src/calibration.cxx
	$(CXX) -o$@ $< $(CFLAGS) $(OPTFLAGS) $(ANYOPTION)

clean:
	rm -f ./AMS_convert
	rm -f ./raw_clusterize
	rm -f ./calibration
