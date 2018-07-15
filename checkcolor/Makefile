CXX := g++
LDFLAGS =
CXXFLAGS = -O2 -std=c++0x
OUTCOLOR := checkcolor.out
COLORSRCS := checkcolor.cpp
OUTCHECK := checkanswer.out
CHECKSRCS := checkanswer.cpp

OBJS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))
DEPS := $(patsubst %.o,%.d, $(OBJS))

.PHONY: all

all: $(OUTCHECK) $(OUTCOLOR)

$(OUTCOLOR): $(patsubst %.cpp,%.o,$(COLORSRCS))

$(OUTCHECK): $(patsubst %.cpp,%.o,$(CHECKSRCS))

%.out:
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -MMD -MT '$@' -o $@ $<

-include $(DEPS)

clean:
	$(RM) $(OBJS) $(DEPS)


