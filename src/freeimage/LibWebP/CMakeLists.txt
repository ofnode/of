# List the header files
set(HEADERS src/dec/alphai.h
         	src/dec/decode_vp8.h
         	src/dec/vp8i.h
         	src/dec/vp8li.h
         	src/dec/webpi.h
         	src/dsp/dsp.h
         	src/dsp/lossless.h
         	src/dsp/yuv.h
         	src/enc/backward_references.h
         	src/enc/cost.h
         	src/enc/histogram.h
         	src/enc/vp8enci.h
         	src/enc/vp8li.h
         	src/mux/muxi.h
         	src/utils/alpha_processing.h
         	src/utils/bit_reader.h
         	src/utils/bit_writer.h
         	src/utils/color_cache.h
         	src/utils/filters.h
         	src/utils/huffman.h
         	src/utils/huffman_encode.h
         	src/utils/quant_levels.h
         	src/utils/quant_levels_dec.h
         	src/utils/random.h
         	src/utils/rescaler.h
         	src/utils/thread.h
         	src/utils/utils.h
         	src/webp/decode.h
         	src/webp/demux.h
         	src/webp/encode.h
         	src/webp/format_constants.h
         	src/webp/mux.h
         	src/webp/mux_types.h
         	src/webp/types.h
)

# List the source files
set(SRCS src/dec/dec_alpha.c
	  	 src/dec/dec_buffer.c
         src/dec/dec_frame.c
         src/dec/dec_idec.c
         src/dec/dec_io.c
         src/dec/dec_layer.c
         src/dec/dec_quant.c
         src/dec/dec_tree.c
         src/dec/dec_vp8.c
         src/dec/dec_vp8l.c
         src/dec/dec_webp.c
         src/dsp/cpu.c
         src/dsp/dec.c
         src/dsp/dec_clip_tables.c
         src/dsp/dec_neon.c
         src/dsp/dec_sse2.c
         src/dsp/enc.c
         src/dsp/enc_neon.c
         src/dsp/enc_sse2.c
         src/dsp/lossless.c
         src/dsp/upsampling.c
         src/dsp/upsampling_neon.c
         src/dsp/upsampling_sse2.c
         src/dsp/yuv.c
         src/enc/enc_alpha.c
         src/enc/enc_analysis.c
         src/enc/enc_backward_references.c
         src/enc/enc_config.c
         src/enc/enc_cost.c
         src/enc/enc_filter.c
         src/enc/enc_frame.c
         src/enc/enc_histogram.c
         src/enc/enc_iterator.c
         src/enc/enc_layer.c
         src/enc/enc_picture.c
         src/enc/enc_quant.c
         src/enc/enc_syntax.c
         src/enc/enc_tree.c
         src/enc/enc_vp8l.c
         src/enc/enc_webpenc.c
         src/enc/token.c
         src/mux/muxedit.c
         src/mux/muxinternal.c
         src/mux/muxread.c
         src/utils/alpha_processing.c
         src/utils/bit_reader.c
         src/utils/bit_writer.c
         src/utils/color_cache.c
         src/utils/filters.c
         src/utils/huffman.c
         src/utils/huffman_encode.c
         src/utils/quant_levels.c
         src/utils/quant_levels_dec.c
         src/utils/random.c
         src/utils/rescaler.c
         src/utils/thread.c
         src/utils/utils.c
)

# Declaration of the library
add_library(webp STATIC ${HEADERS} ${SRCS})

set_target_properties(webp PROPERTIES COMPILE_FLAGS "-w -fPIC")

