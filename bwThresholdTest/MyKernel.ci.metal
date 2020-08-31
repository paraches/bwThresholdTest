//
//  MyKernel.ci.metal
//  bwThresholdTest
//
//  Created by shinichi teshirogi on 2020/08/28.
//  Copyright © 2020 paraches lifestyle lab. All rights reserved.
//

//
//  code from: https://gist.github.com/xhruso00/a3f8a9c8ae7e33b8b23d
//

#include <metal_stdlib>
using namespace metal;

constant float3 kRec709Luma  = float3(0.2126, 0.7152, 0.0722);
constant float3 kRec601Luma  = float3(0.299 , 0.587 , 0.114);

#include <CoreImage/CoreImage.h>

extern "C" { namespace coreimage {
  
    float lumin601(float3 p)
    {
        return dot(p.rgb, kRec601Luma);
    }
    
    float lumin709(float3 p)
    {
        return dot(p.rgb, kRec709Luma);
    }
    
    float4 thresholdFilter(sample_t image, float threshold)
    {
        float4 pix = unpremultiply(image);
        float luma = lumin601(pix.rgb);
        pix.rgb = float3(step(threshold, luma));
        return premultiply(pix);
    }
}}
