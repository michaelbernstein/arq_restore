/*
 Copyright (c) 2009-2017, Haystack Software LLC https://www.arqbackup.com
 
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the names of PhotoMinds LLC or Haystack Software, nor the names of
 their contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */



#import "S3AuthorizationProviderFactory.h"
#import "AWSRegion.h"
#import "S3SignatureV1AuthorizationProvider.h"
#import "S3SignatureV4AuthorizationProvider.h"


@implementation S3AuthorizationProviderFactory
CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(S3AuthorizationProviderFactory)

- (id <S3AuthorizationProvider>)providerForEndpoint:(NSURL *)theEndpoint
                                          accessKey:(NSString *)theAccessKey
                                          secretKey:(NSString *)theSecretKey
                                   signatureVersion:(int)theSignatureVersion
                                          awsRegion:(AWSRegion *)theAWSRegion {
    id <S3AuthorizationProvider> ret = nil;
    
    NSAssert(theSignatureVersion == 2 || theSignatureVersion == 4, @"signature version must be 2 or 4");
    
    if (theSignatureVersion == 4) {
        ret = [[[S3SignatureV4AuthorizationProvider alloc] initWithAccessKey:theAccessKey secretKey:theSecretKey awsRegion:theAWSRegion] autorelease];
    } else {
        ret = [[[S3SignatureV1AuthorizationProvider alloc] initWithAccessKey:theAccessKey secretKey:theSecretKey] autorelease];
    }
    
    return ret;
}
@end
