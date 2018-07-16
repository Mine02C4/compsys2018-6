VDIR := mipse

.PHONY: all test clean input answers validate

export PNUMBERS := $(patsubst input/Q%.txt, %, $(wildcard input/Q*.txt))

all: validate answers input

input:
	$(MAKE) -C $@

answers: input
	$(MAKE) -C $(VDIR) $@

validate: answers input
	$(MAKE) -C checkcolor validate

test:

clean:

