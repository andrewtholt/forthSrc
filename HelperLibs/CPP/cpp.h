#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
#include <string>
class myVector {
    private:
        std::vector<void *> *v;
    public:
        myVector();
        myVector(int size);

        void append(void *n);
        void *get(int n);
        int size();
        void erase(int n);  // Erase a single entry
        void erase();		// kill 'em all
        // TBD
        void *getFirst(); // use front
        void *getLast();	// use back
        void *popLast();
};

class myMap {
private:
	std::map<std::string, void *> *m;
public:
	myMap();
	void add(std::string n, void *v);
    int size();
    void *get(std::string n);
    bool exists(std::string n);
    void eraseAll();
    void erase(std::string n);
};
#endif

#ifdef __cplusplus
extern "C" {
#endif
    struct myVector *newVector();
    int vectorSize(struct myVector *p);
    void vectorAppend(struct myVector *p, void *n);
    void vectorErase(struct myVector *p, int n);
    void vectorEraseAll(struct myVector *p);

    struct myMap *newMap();
    int mapSize(struct myMap *m);
    void mapAdd(struct myMap *m, char *n, void *v);
    void *mapGet(struct myMap *m, char *n);
    bool mapExists(struct myMap *m, char *n);
    void mapEraseAll(struct myMap *p);
    void mapErase(struct myMap *m, char *n);
#ifdef __cplusplus
}
#endif
