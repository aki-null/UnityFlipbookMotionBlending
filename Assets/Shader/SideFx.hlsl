// Unity Flipbook Motion Blending
//
// Copyright (c) 2024 Akihiro Noguchi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// -----------------------------------------------------------------------------
//
// Original Code License:
//
// Copyright (c) 2020 Side Effects Software Inc. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice, this list
// of conditions and the following disclaimer.
//
// The name of Side Effects Software may not be used to endorse or promote products
// derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY SIDE EFFECTS SOFTWARE 'AS IS' AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
// SHALL SIDE EFFECTS SOFTWARE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
// IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
// OF SUCH DAMAGE.
//
// -----------------------------------------------------------------------------
//
// Note: This software includes a port of the "SideFX Labs R8G8 Encoding" algorithm.
// The use of the name "SideFX" is for descriptive purposes only and does not imply
// any endorsement or affiliation with Side Effects Software Inc.
//

void SideFX_DecodeMotionVector_float(float2 encoded, out float2 result) {
    float2 mapped = round(encoded * 255.0);

    // Extract the MSB from the green component.
    // This bit flips the direction vector to the opposite.
    float polarFlipBit = floor(mapped.g / 128.0);
    // Extract the remaining bits from the green component.
    // These bits represent the length of the motion vector.
    float magnitudeBits = fmod(mapped.g, 128.0);

    // Decode the polar coordinate.
    // 8 bits from the red channel are used as a base in the range [0, 255], which
    // maps the polar coordinate in the right half of the circle.
    // The polar flip bit obtained above is used to offset the polar
    // coordinate by half a circle, flipping the direction vector.
    float encodedPolar = mapped.r + polarFlipBit * 256.0;
    // Remap from [0, 511] to [0, 1].
    float polar01 = encodedPolar / 511.0;
    // Remap from [0, 1] to [0, 2 * PI].
    float polar = polar01 * PI * 2.0;
    // Convert to the direction vector.
    float dirX = cos(polar);
    float dirY = sin(polar);

    // Remap the magnitude from [0, 127] to [0, 1].
    float magnitude = magnitudeBits / 127.0;

    result = float2(dirX * magnitude, dirY * magnitude);
}