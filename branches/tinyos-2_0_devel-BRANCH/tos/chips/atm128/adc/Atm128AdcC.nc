/// $Id: Atm128AdcC.nc,v 1.1.2.5 2006-01-20 23:08:13 idgay Exp $

/**
 * Copyright (c) 2004-2005 Crossbow Technology, Inc.  All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL CROSSBOW TECHNOLOGY OR ANY OF ITS LICENSORS BE LIABLE TO 
 * ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL 
 * DAMAGES ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN
 * IF CROSSBOW OR ITS LICENSOR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH 
 * DAMAGE. 
 *
 * CROSSBOW TECHNOLOGY AND ITS LICENSORS SPECIFICALLY DISCLAIM ALL WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS 
 * ON AN "AS IS" BASIS, AND NEITHER CROSSBOW NOR ANY LICENSOR HAS ANY 
 * OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR 
 * MODIFICATIONS.
 *
 * Copyright (c) 2005 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */
/**
 * @author Hu Siquan <husq@xbow.com>
 * @author David Gay
 */

#include "Atm128Adc.h"

configuration Atm128AdcC
{
  provides {
    interface Resource[uint8_t client];
    interface Atm128AdcSingle[uint8_t channel];
    interface Atm128AdcMultiple;
  }
}
implementation
{
  components Atm128AdcP, HplAtm128AdcC, PlatformC, MainC,
    new RoundRobinArbiterC(UQ_ATM128ADC_RESOURCE) as AdcArbiter,
    new StdControlPowerManagerC() as PM;

  Resource = AdcArbiter;
  Atm128AdcSingle = Atm128AdcP;
  Atm128AdcMultiple = Atm128AdcP;

  PlatformC.SubInit -> Atm128AdcP;

  Atm128AdcP.HplAtm128Adc -> HplAtm128AdcC;

  PM.Init <- MainC;
  PM.StdControl -> Atm128AdcP;
  PM.ArbiterInit -> AdcArbiter;
  PM.ResourceController -> AdcArbiter;
  PM.ArbiterInfo -> AdcArbiter;
}
