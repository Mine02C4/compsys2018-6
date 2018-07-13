CXX := g++
LDFLAGS =
CXXFLAGS = -O2 -std=c++0x
OUTPUT := checkcolor.out
SRCS = checkcolor.cpp

OBJS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))
DEPS := $(patsubst %.o,%.d, $(OBJS))

.PHONY: all

all: $(OUTPUT)

$(OUTPUT): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS) $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -MMD -MT '$@' -o $@ $<

-include $(DEPS)

clean:
	$(RM) $(OBJS) $(DEPS)


