appname := hesaff

PARALLELOPENCV=$(HOME)/ParallelOpenCV
INCLUDE=$(PARALLELOPENCV)/include
OPENCVLIB=$(PARALLELOPENCV)/lib

CXX := icpc
CXXFLAGS := -I /opt/intel/advisor_2017.1.1.486553/include/ -I$(INCLUDE) -O3 -g -qopt-report=5 -simd -Bdynamic -parallel -qopenmp -parallel-source-info=2 -ldl -qopenmp-link dynamic -debug inline-debug-info -shared-intel -xCORE-AVX2 -Wall -std=c++11


LDFLAGS= -L$(OPENCVLIB) -O3 -g -qopt-report=5 -simd -Bdynamic -parallel -qopenmp -parallel-source-info=2 -ldl -qopenmp-link dynamic -debug inline-debug-info -shared-intel -xCORE-AVX2 -Wall -std=c++11
LDLIBS= -lopencv_core -lopencv_highgui -lopencv_imgproc -lopencv_imgcodecs

srcfiles := $(shell find . -name "*.cpp")
headerfiles := $(shell find . -name "*.hpp")

objects := $(patsubst %.cpp,%.o,$(notdir $(srcfiles)))

VPATH := $(sort $(dir $(srcfiles)))

all: $(srcfiles) $(appname)

$(appname): $(objects)
	$(CXX) $(LDFLAGS) -o $(appname) $(objects) $(LDLIBS)

depend: .depend

.depend: $(srcfiles) $(headerfiles)
	rm -f ./.depend
	$(CXX) $(CXXFLAGS) $(CXXDISALBE) -MM $^>>./.depend;

clean:
	rm -f $(appname) $(objects)

dist-clean: clean
	rm -f *~ .depend

include .depend

