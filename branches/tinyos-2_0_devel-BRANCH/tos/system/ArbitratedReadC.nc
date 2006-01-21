/* $Id: ArbitratedReadC.nc,v 1.1.2.2 2006-01-21 01:31:41 idgay Exp $
 * Copyright (c) 2005 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */
/**
 * Implement arbitrated access to an Read interface, based on an
 * underlying arbitrated Resource interface.
 *
 * @author David Gay
 */
generic module ArbitratedReadC(typedef width_t) {
  provides interface Read<width_t>[uint8_t client];
  uses {
    interface Read<width_t> as Service[uint8_t client];
    interface Resource[uint8_t client];
  }
}
implementation {
  command error_t Read.read[uint8_t client]() {
    return call Resource.request[client]();
  }

  event void Resource.granted[uint8_t client]() {
    call Service.read[client]();
  }

  event void Service.readDone[uint8_t client](error_t result, width_t data) {
    call Resource.release[client]();
    signal Read.readDone[client](result, data);
  }

  default async command error_t Resource.request[uint8_t client]() { 
    return SUCCESS; 
  }
  default async command void Resource.release[uint8_t client]() { }
  default event void Read.readDone[uint8_t client](error_t result, width_t data) { }
  default command error_t Service.read[uint8_t client]() {
    return SUCCESS;
  }
}
