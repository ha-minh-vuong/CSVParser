CSVParser
========

A CSV Parser for iOS and OSX.

It can parse csv file into an array of arrays or an array of dictionaries.

The csv file can contain single quote <code>'</code> or double quote <code>"</code>.

Usage
-----

Adding <code>CSVParser.h</code> and <code>CSVParser.m</code> to your Xcode project.


1. Import the CSVParser class header:

                        #import "CSVParser.h"

2. Create an array from file:

                        NSArray *arrayOfArrays = [CSVParser parseCSVIntoArrayOfArraysFromFile:filePath
                                                                 withSeparatedCharacterString:@","
                                                                         quoteCharacterString:nil]; // nil, if csv dont have quote.

                        NSArray *arrayOfDictionaries = [CSVParser parseCSVIntoArrayOfDictionariesFromFile:filePath
                                                                             withSeparatedCharacterString:@","
                                                                                     quoteCharacterString:@"\""]; // if csv contains ".

Example
-------

Assume you have a csv file:

    name,email,address
    "Lucky Star",lucky@abc.com,"1A street"
    "Joe A",joe@abc.com,"2B street"

Array of arrays:

    NSArray *arrayOfArrays = [CSVParser parseCSVIntoArrayOfArraysFromFile:filePath
                                             withSeparatedCharacterString:@","
                                                     quoteCharacterString:@"\""];

    (("name","email","address"),
     ("Lucky Star","lucky@abc.com","1A street"),
     ("Joe A","joe@abc.com","2B street"))

Array of dictionaries:

    NSArray *arrayOfDictionaries = [CSVParser parseCSVIntoArrayOfDictionariesFromFile:filePath
                                                         withSeparatedCharacterString:@","
                                                                 quoteCharacterString:@"\""];

    ({"name" = "Lucky Star";
      "email" = "lucky@abc.com";
      "address" = "1A street";},
     {"name" = "Joe A";
      "email" = "joe@abc.com";
      "address" = "2B street";})

Contact
-------

vuong.haminh@gmail.com

License - BSD
-------

Copyright (c) 2012, Ha Minh Vuong.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met: 

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
