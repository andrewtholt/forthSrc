
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <map>
#include <vector>
#include "cpp.h"


using namespace std;

myVector::myVector() {
    v = new vector<void *>;
}

void myVector::append(void *n) {
    v->push_back(n);
}

void *myVector::get(int n){
	return(v->at(n));
}

int myVector::size() {
    return v->size();
}

void myVector::erase(int n) {
	v->erase(v->begin()+n);
}

void myVector::erase() {
	v->erase(v->begin(), v->end());
}

myMap::myMap() {
	m = new map<std::string, void *>;
}

void myMap::add(std::string n, void *v){
	m->emplace(n,v);
}

int myMap::size() {
    return m->size();
}

void *myMap::get(std::string n){
	return(m->at(n));
}

bool myMap::exists(std::string n) {
	bool rc=false;
	if( m->count(n) == 0 ) {
		rc = false;
	} else {
		rc = true;
	}
	return rc;
}

void myMap::eraseAll() {
	m->clear();
}

void myMap::erase(std::string n) {
	std::map<std::string, void *>::iterator it;

	it=m->find(n);
	if( it !=m->end() ) {
		m->erase(it);
	}
}

extern "C" {
    struct myVector *newVector() {
        return (new myVector);
    }

    int vectorSize(myVector *p) {
        return(p->size());
    }

    void vectorAppend(struct myVector *p, void *n) {
        p->append(n);
    }

    void *vectorGet(struct myVector *p, int n) {
        p->get(n);
    }

    void vectorErase(struct myVector *p, int n) {
        p->erase(n);
    }

    void vectorEraseAll(struct myVector *p) {
        p->erase();
    }

    struct myMap *newMap() {
    	return (new myMap);
    }

    void mapAdd(struct myMap *m, char *n,  void *v) {
    	m->add(n,v);
    }

    void *mapGet(struct myMap *m, char *n){
    	return( m->get(n));
    }

    int mapSize(myMap *m) {
        return(m->size());
    }

    bool mapExists(struct myMap *m, char *n) {
    	return(m->exists(n));
    }

    void mapEraseAll(struct myMap *m) {
    	m->eraseAll();
    }

    void mapErase(struct myMap *m, char *n) {
    	m->erase(n);
    }



}
