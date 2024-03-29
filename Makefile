ifeq ($(CXX),)
	CXX = clang++
endif

GCC-debug = $(CXX) -std=c++20 -Iinclude -g
GCC-static = $(CXX) -std=c++20 -static -Iinclude -O2
GCC-small = $(CXX) -std=c++20 -Iinclude -Os

ifeq ($(Version),release)
	GCC = $(GCC-static)
	EXE = AkashaDDNS
else ifeq ($(Version),release-min)
	GCC = $(GCC-small)
	EXE = AkashaDDNS-min
else
	GCC = $(GCC-debug)
	EXE = AkashaDDNS-d
endif

ifeq ($(OS),Windows_NT)
	Link = -lssl \
		   -lcrypto \
		   -lws2_32 \
		   -lcrypt32
    
else
    # Linux/Unix
	Link = -lssl \
		   -lcrypto
    
endif

RM = rm src/*.o
CR = rm AkashaDDNS*

obj = $(wildcard src/*.cpp)


%.o: %.cpp
	$(GCC) -c $< -o $@ 

AkashaDDNS: $(obj)
	$(GCC) $^ -o $(EXE) $(Link)

all:
	make AkashaDDNS
	make clean
	make AkashaDDNS Version=release
	make clean
	make AkashaDDNS Version=release-min

clear:
	$(RM)
	$(CR)

clean:
	$(RM)
