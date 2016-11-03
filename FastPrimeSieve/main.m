//
//  main.m
//  FastPrimeSieve
//
//  Created by KTachyon on 05/01/14.
//  Copyright (c) 2014 KTachyon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define maximum 1000000000

int leftValueForIndex(int i) { return i * 6 - 1; }
int rightValueForIndex(int i) { return i * 6 + 1; }

int shiftForBitIndex(int i) { return i % 8; }
int arrayIndexForBitIndex(int i) { return i / 8; }

int getBitValue(char *array6, int index) {
    int arrayPosition = index / 8;
    int shift = index % 8;
    
    return array6[arrayPosition] & (1 << shift);
}

void setBitValue(char *array6, int index) {
    int arrayPosition = index / 8;
    int shift = index % 8;
    
    array6[arrayPosition] = array6[arrayPosition] | (1 << shift);
}

int zeroIndexedLeftValueForIndex(int i, char* left6) { return /*getBitValue(left6, i)*/ left6[i] == 0 ? leftValueForIndex(i + 1) : -1; }
int zeroIndexedRightValueForIndex(int i, char* right6) { return /*getBitValue(right6, i)*/ right6[i] == 0 ? rightValueForIndex(i + 1) : -1; }

void markNonPrimes(int startLine, int listSize, int currentPrime, int jump, char *main6, char *side6) {
    for (int i = startLine + currentPrime - jump; i < listSize; i += currentPrime) {
        if (i + jump < listSize) {
            main6[i + jump] = -1;
            //setBitValue(main6, i + jump);
        }
        
        //setBitValue(side6, i);
        side6[i] = -1;
    }
}

void print(int l, int r) {
    NSLog(@" %d\t\t\t%d", l, r);
}

void erathostenesEuler(char *left6, char *right6, int listSize) {
    int sqroot = sqrt(listSize);
    
    for (int i = 0; i < sqroot; i++) {
        int jump = (i + 1) * 2;
        int l = left6[i] == 0 ? i * 6 + 5 : -1;
        int r = right6[i] == 0 ? i * 6 + 7 : -1;
        
        if (l != -1) { markNonPrimes(i, listSize, l, jump, left6, right6); }
        if (r != -1) { markNonPrimes(i, listSize, r, jump, right6, left6); }
    }
}

/*void erathostenesEuler(char *left6, char *right6, int listSize) {
    int sqroot = sqrt(listSize);
    
    for (int i = 0; i < sqroot; i++) {
        int jump = (i + 1) * 2;
        int l = zeroIndexedLeftValueForIndex(i, left6);
        int r = zeroIndexedRightValueForIndex(i, right6);
        
        if (l != -1) { markNonPrimes(i, listSize, l, jump, left6, right6); }
        if (r != -1) { markNonPrimes(i, listSize, r, jump, right6, left6); }
    }
}*/

int main(int argc, const char * argv[]) {
    int listSize = maximum / 6;
    
    char* left6 = calloc(listSize/* / 8*/, sizeof(char));
    char* right6 = calloc(listSize/* / 8*/, sizeof(char));
    
    double start = CFAbsoluteTimeGetCurrent();
    
    erathostenesEuler(left6, right6, listSize);
    
    NSLog(@"Primes found: %lf", CFAbsoluteTimeGetCurrent() - start);
    
    int count = 2; // primes 2 and 3
    
    for (int i = 0; i < listSize; i++) {
        int l = zeroIndexedLeftValueForIndex(i, left6);
        int r = zeroIndexedRightValueForIndex(i, right6);
        
        if (l != -1) {
            //NSLog(@" %d", l);
            count++;
        }
        
        if (r != -1) {
            //NSLog(@" %d", r);
            count++;
        }
    }
    
    NSLog(@"Found %d primes", count);
    
    /*for (int i = 0; i < listSize; i++) {
        int l = zeroIndexedLeftValueForIndex(i, left6);
        int r = zeroIndexedRightValueForIndex(i, right6);
        
        print(l, r);
    }*/
    
    return 0;
}

