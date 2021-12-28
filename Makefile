CXX=clang++ -std=c++17
NM=nm -C
FILTER_SYMBOLS=grep -E ' (U|D|T|V) '

.DEFAULT_GOAL := analyze

main.o: main.cc foo.h
	$(CXX) -c main.cc -o main.o

foo.o: foo.cc foo.h
	$(CXX) -c foo.cc -o foo.o

main: main.o foo.o
	$(CXX) main.o foo.o -o main

libfoo.so: foo.cc foo.h
	$(CXX) -DBUILD_SHARED -DFOO_IMPL -shared -fPIC foo.cc -o libfoo.so

main_shared: main.cc foo.h libfoo.so
	$(CXX) -DBUILD_SHARED -fPIC main.cc -L./ -Wl,-rpath=./ -lfoo -o main_shared

.PHONY: clean
clean:
	rm -f main.o foo.o main libfoo.so main_shared

.PHONY: analyze
analyze: main main.o foo.o libfoo.so main_shared
	@echo
	@echo "Key: U = undefined symbol, D = symbol defined in \"data\", T = symbol defined in \"text\", V = \"weak\" symbol"
	@echo
	@echo "Analysis of artifacts (static linking):"
	@echo
	@echo "foo.o:"
	@$(NM) foo.o | $(FILTER_SYMBOLS)
	@echo
	@echo "main.o:"
	@$(NM) main.o | $(FILTER_SYMBOLS)
	@echo
	@echo "Running 'main':"
	@./main
	@echo
	@echo "Analysis of artifacts (dynamic linking):"
	@echo
	@echo "libfoo.so:"
	@$(NM) libfoo.so | $(FILTER_SYMBOLS)
	@echo
	@echo "main_shared:"
	@$(NM) main_shared | $(FILTER_SYMBOLS)
	@echo
	@echo "Running 'main_shared':"
	@./main_shared
