/*
 * Copyright (c) 2004, Technische Universitat Berlin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 * - Neither the name of the Technische Universitat Berlin nor the names
 *   of its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.2.2 $
 * $Date: 2005-05-24 16:29:04 $ 
 * ======================================================================== 
 */
 
 /**
 * HPLTDA5250M configuration  
 * Controlling the TDA5250 at the HPL layer.. 
 *
 * @author Kevin Klues (klues@tkn.tu-berlin.de)
 */
 
#include "tda5250Const.h"
#include "tda5250RegDefaultSettings.h"
#include "tda5250RegTypes.h"
configuration HPLTDA5250C {
  provides {
    interface Init;  
    interface TDA5250Config;
    interface TDA5250DataComm;
    interface TDA5250DataControl;
    interface Resource as ConfigResource;
    interface Resource as DataResource;
  }
}
implementation {
  components HPLTDA5250M
           , TDA5250RegistersC
           , PlatformTDA5250CommC
           , TDA5250RadioIO
           , TDA5250RadioInterruptPWDDD
           ;
   
  Init = HPLTDA5250M;
  Init = TDA5250RegistersC;  
  Init = PlatformTDA5250CommC;
  
  ConfigResource = PlatformTDA5250CommC.RegResource;
  DataResource = PlatformTDA5250CommC.DataResource;
  
  TDA5250Config = HPLTDA5250M;
  TDA5250DataComm = PlatformTDA5250CommC;
  TDA5250DataControl = PlatformTDA5250CommC;
  
  HPLTDA5250M.CONFIG -> TDA5250RegistersC.CONFIG;
  HPLTDA5250M.FSK -> TDA5250RegistersC.FSK;
  HPLTDA5250M.XTAL_TUNING -> TDA5250RegistersC.XTAL_TUNING;
  HPLTDA5250M.LPF -> TDA5250RegistersC.LPF;
  HPLTDA5250M.ON_TIME -> TDA5250RegistersC.ON_TIME;
  HPLTDA5250M.OFF_TIME -> TDA5250RegistersC.OFF_TIME;
  HPLTDA5250M.COUNT_TH1 -> TDA5250RegistersC.COUNT_TH1;
  HPLTDA5250M.COUNT_TH2 -> TDA5250RegistersC.COUNT_TH2;
  HPLTDA5250M.RSSI_TH3 -> TDA5250RegistersC.RSSI_TH3;
  HPLTDA5250M.CLK_DIV -> TDA5250RegistersC.CLK_DIV;
  HPLTDA5250M.XTAL_CONFIG -> TDA5250RegistersC.XTAL_CONFIG;
  HPLTDA5250M.BLOCK_PD -> TDA5250RegistersC.BLOCK_PD;
  HPLTDA5250M.STATUS -> TDA5250RegistersC.STATUS;
  HPLTDA5250M.ADC -> TDA5250RegistersC.ADC;  
  
  HPLTDA5250M.PWDDD -> TDA5250RadioIO.TDA5250RadioPWDDD;    
  HPLTDA5250M.TXRX -> TDA5250RadioIO.TDA5250RadioTXRX;  
  HPLTDA5250M.PWDDDInterrupt -> TDA5250RadioInterruptPWDDD;
}
