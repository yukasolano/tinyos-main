/*
 * "Copyright (c) 2005 Stanford University. All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose, without fee, and without written
 * agreement is hereby granted, provided that the above copyright
 * notice, the following two paragraphs and the author appear in all
 * copies of this software.
 * 
 * IN NO EVENT SHALL STANFORD UNIVERSITY BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN
 * IF STANFORD UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 * 
 * STANFORD UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND STANFORD UNIVERSITY
 * HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES,
 * ENHANCEMENTS, OR MODIFICATIONS."
 */

/**
 * Declaration of C++ objects representing TOSSIM abstractions.
 * Used to generate Python objects.
 *
 * @author Philip Levis
 * @date   Nov 22 2005
 */

// $Id: tossim.h,v 1.1.2.6 2006-01-08 07:14:21 scipio Exp $

#ifndef TOSSIM_H_INCLUDED
#define TOSSIM_H_INCLUDED

//#include <stdint.h>
#include <memory.h>
#include <tos.h>
#include <mac.h>
#include <radio.h>
#include <packet.h>

typedef struct var_string {
  char* ptr;
  int len;
} var_string_t;

class Variable {
 public:
  Variable(char* name, int mote);
  ~Variable();
  var_string_t getData();
  
 private:
  char* name;
  int mote;
  void* ptr;
  char* data;
  int len;
  var_string_t str;
};

class Mote {
 public:
  Mote();
  ~Mote();

  unsigned long id();
  
  long long int euid();
  void setEuid(long long int id);

  long long int bootTime();
  void bootAtTime(long long int time);

  bool isOn();
  void turnOff();
  void turnOn();
  void setID(unsigned long id);  

  Variable* getVariable(char* name);
  
 private:
  unsigned long nodeID;
};

class Tossim {
 public:
  Tossim();
  ~Tossim();
  
  void init();
  
  long long int time();
  char* timeStr();
  void setTime(long long int time);
  
  Mote* currentNode();
  Mote* getNode(unsigned long nodeID);
  void setCurrentNode(unsigned long nodeID);

  bool addChannel(char* channel, FILE* file);
  bool removeChannel(char* channel, FILE* file);
  
  bool runNextEvent();

  MAC* mac();
  Radio* radio();
  Packet* newPacket();
  
 private:
  char timeBuf[256];
};



#endif // TOSSIM_H_INCLUDED
