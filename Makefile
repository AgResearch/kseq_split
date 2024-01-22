all: build/kseq_test build/kseq_split build/kseq_count
.PHONY: all

LDLIBS += -lz

build/kseq_test: kseq_test.c kseq.h
	test -d build || mkdir -p build
	$(CC) $< $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) $(TARGET_ARCH) -o $@

build/kseq_split: kseq_split.c kseq.h
	test -d build || mkdir -p build
	$(CC) $< $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) $(TARGET_ARCH) -o $@

build/kseq_count: kseq_count.c kseq.h
	test -d build || mkdir -p build
	$(CC) $< $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) -lm $(TARGET_ARCH) -o $@

clean:
	rm -rf build
