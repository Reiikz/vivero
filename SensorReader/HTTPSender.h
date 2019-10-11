#pragma once

#include <Arduino.h>
#include "NetworkCommunication.h"

class HTTPSender{

  public:

    static const word PORT = 80;
  
    HTTPSender()
    {
      
    }

    static String send(String url, char* host);
  
};
