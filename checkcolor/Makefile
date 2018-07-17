CXX := g++
LDFLAGS =
CXXFLAGS = -O2 -std=c++0x
OUTCOLOR := checkcolor.out
COLORSRCS := checkcolor.cpp
OUTCHECK := checkanswer.out
CHECKSRCS := checkanswer.cpp

OBJS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))
DEPS := $(patsubst %.o,%.d, $(OBJS))

VDIR := ../mipse
INPUTDIR := ../input
JOBS := $(patsubst %, job%, $(PNUMBERS))

.PHONY: all validate clean

all: $(OUTCHECK) $(OUTCOLOR) checkcolor2.out

validate: $(JOBS)

job%: $(OUTCHECK) $(VDIR)/answer%.txt $(INPUTDIR)/Q%.txt
	./$^

$(OUTCOLOR): $(patsubst %.cpp,%.o,$(COLORSRCS))

$(OUTCHECK): $(patsubst %.cpp,%.o,$(CHECKSRCS))

checkcolor2.out: checkcolor2.o

%.out:
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -MMD -MT '$@' -o $@ $<

-include $(DEPS)

clean:
	$(RM) $(OBJS) $(DEPS)

