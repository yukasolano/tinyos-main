module PlatformC { 
  provides interface Init;
}
implementation {
  command error_t Init.init() {
    return SUCCESS;
  }
}
