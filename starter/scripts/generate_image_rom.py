#!/usr/bin/env python3
# Copyright (c) 2024 Ethan Sifferman.
# All rights reserved. Distribution Prohibited.

from PIL import Image
import sys

def rgb_to_bit(r, g, b):
    return f"{1 if (r or g or b) else 0}"

def convert_image_to_memh(input_filename, output_filename):
    image = Image.open(input_filename).convert("RGB")

    width, height = image.size

    with open(output_filename, 'w') as outfile:
        outfile.write(f"// Image ROM generated from \"{input_filename}\"\n")
        outfile.write(f"// 1-bit color depth\n")
        outfile.write(f"// Dimensions: {width}x{height}\n")
        outfile.write(f"\n")
        for y in range(height):
            for x in range(width):
                r, g, b = image.getpixel((x, y))
                bit_value = rgb_to_bit(r, g, b)
                outfile.write(bit_value)
            outfile.write("\n")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <input_png> <output_file>")
        sys.exit(1)

    input_filename = sys.argv[1]
    output_filename = sys.argv[2]

    convert_image_to_memh(input_filename, output_filename)
