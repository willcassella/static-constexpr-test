CXX=clang++ -std=c++17
NM=nm -C
.DEFAULT_GOAL := analyze

main.o: main.cc foo.h
	$(CXX) -c main.cc -o main.o

foo.o: foo.cc foo.h
	$(CXX) -c foo.cc -o foo.o

main: main.o foo.o
	$(CXX) main.o foo.o -o main

.PHONY: clean
clean:
	rm -f main main.o foo.o

.PHONY: analyze
analyze: main main.o foo.o
	@echo
	@echo "Analysis of artifacts:"
	@echo "U = undefined symbol, T = \"text\" symbol, V = \"weak\" symbol, r = read-only symbol"
	@echo
	@echo "foo.o:"
	@$(NM) foo.o
	@echo
	@echo "main.o:"
	@$(NM) main.o
	@echo
	@echo "Running 'main':"
	@./main
