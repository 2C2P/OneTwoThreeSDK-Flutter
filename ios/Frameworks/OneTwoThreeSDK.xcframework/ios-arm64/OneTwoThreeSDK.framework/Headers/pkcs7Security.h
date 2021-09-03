//
//  pkcs7Security.h
//  pkcs7Security
//
//  Created by Htain Lin Shwe on 8/10/12.
//  Copyright (c) 2012 2c2p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pkcs7Security : NSObject

/**
 to encrypt the String with Public Key
 
 text is the string that you want to encrypt
 
 Path is the file Path
 
 */
+(NSString*)encryptText:(NSString*)text WithPublicKey:(NSString*)publicKey Error:(NSError **)error;
/**
 to decrypt the base64 to String
 
 base64 is a base64 string
 
 pemPath is the PEM key path (private key path)
 
 pass is the passpharse of PEM key
 
 */
+(NSString*)decryptText:(NSString*)base64 WithPrivateKey:(NSString*)privateKey AndPassphrase:(NSString*)pass Error:(NSError **)error;
@end
