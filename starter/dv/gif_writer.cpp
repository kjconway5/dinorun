// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

#include <gif_lib.h>

#include <stdlib.h>
#include <string.h>

typedef struct {
    GifFileType *gif_file;
    ColorMapObject *color_map;
    int width, height;
    int current_frame;
    GifByteType *frame_buffer;
    int frame_delay;
} GifWriter;

void set_loop_block(GifWriter * writer) {
    EGifPutExtensionLeader(writer->gif_file, APPLICATION_EXT_FUNC_CODE);

    static const GifByteType netscape_identifier[] = {
        'N', 'E', 'T', 'S', 'C', 'A', 'P', 'E',
        '2', '.', '0'
    };
    EGifPutExtensionBlock(writer->gif_file, sizeof(netscape_identifier), netscape_identifier);

    static const GifByteType loop_count[] = {
        1, 0, 0
    };
    EGifPutExtensionBlock(writer->gif_file, sizeof(loop_count), loop_count);

    EGifPutExtensionTrailer(writer->gif_file);
}

// Initialize a color map with 64 colors
void initialize_color_map(ColorMapObject *color_map) {
    for (int r = 0; r < 4; ++r) {
        for (int g = 0; g < 4; ++g) {
            for (int b = 0; b < 4; ++b) {
                int index = (r << 4) | (g << 2) | b;
                color_map->Colors[index].Red = r * 85;
                color_map->Colors[index].Green = g * 85;
                color_map->Colors[index].Blue = b * 85;
            }
        }
    }
}


// DPI Functions
extern "C" {



void gif_write_pixel(GifWriter *writer, int x, int y, int r, int g, int b) {
    if (x < 0 || x >= writer->width || y < 0 || y >= writer->height) return;

    int rr = (r>>6)&3;
    int gg = (g>>6)&3;
    int bb = (b>>6)&3;

    int color_index = (rr << 4) | (gg << 2) | bb;

    writer->frame_buffer[y * writer->width + x] = color_index;
}

GifWriter *gif_open(const char *filename, int width, int height) {
    GifWriter *writer = (GifWriter *)malloc(sizeof(GifWriter));

    writer->gif_file = EGifOpenFileName(filename, false, NULL);
    if (!writer->gif_file) {
        free(writer);
        return NULL;
    }

    writer->width = width;
    writer->height = height;
    writer->current_frame = -1;
    writer->frame_delay = 2;

    int color_count = 64;
    writer->color_map = GifMakeMapObject(color_count, NULL);
    initialize_color_map(writer->color_map);

    // Set up screen descriptor
    EGifPutScreenDesc(writer->gif_file, width, height, color_count, 0, writer->color_map);

    set_loop_block(writer);

    writer->frame_buffer = (GifByteType *)malloc(width * height * sizeof(GifByteType));

    return writer;
}

void gif_next_frame(GifWriter *writer) {
    if (writer->current_frame >= 0) {
        // Convert Graphics Control Block to Extension
        GraphicsControlBlock gcb = {DISPOSAL_UNSPECIFIED, false, writer->frame_delay, -1};
        GifByteType extension[sizeof(GraphicsControlBlock) + 1];
        size_t length = EGifGCBToExtension(&gcb, extension);

        EGifPutExtension(writer->gif_file, GRAPHICS_EXT_FUNC_CODE, length, extension);
        EGifPutImageDesc(writer->gif_file, 0, 0, writer->width, writer->height, false, NULL);
        EGifPutLine(writer->gif_file, writer->frame_buffer, writer->width * writer->height);
    }

    // Initialize frame buffer for the new frame
    memset(writer->frame_buffer, 0, writer->width * writer->height * sizeof(GifByteType));
    writer->current_frame++;
}

int gif_close(GifWriter *writer) {
    if (!writer) return GIF_ERROR;

    gif_next_frame(writer);

    free(writer->frame_buffer);
    GifFreeMapObject(writer->color_map);
    free(writer);
    return GIF_OK;
}



}
