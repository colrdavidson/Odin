package objc_Foundation

import "core:strings"
import "core:runtime"
import "core:intrinsics"
import "core:fmt"

OpenGLPixelFormatAttribute :: distinct u32

OpenGLPFADoubleBuffer  :: 5
OpenGLPFAColorSize     :: 8
OpenGLPFAAlphaSize     :: 11
OpenGLPFADepthSize     :: 12
OpenGLPFAStencilSize   :: 13
OpenGLPFASampleBuffers :: 55
OpenGLPFAAccelerated   :: 73
OpenGLPFAOpenGLProfile  :: 99
OpenGLProfileVersion3_2Core :: 0x3200

OpenGLContextParameterSwapInterval : Integer = 222

@(objc_class="NSOpenGLPixelFormat")
OpenGLPixelFormat :: struct {using _: Object }

@(objc_type=OpenGLPixelFormat, objc_name="alloc", objc_is_class_method=true)
OpenGLPixelFormat_alloc :: proc "c" () -> ^OpenGLPixelFormat {
    return msgSend(^OpenGLPixelFormat, OpenGLPixelFormat, "alloc")
}

@(objc_type=OpenGLPixelFormat, objc_name="initWithAttributes")
OpenGLPixelFormat_initWithAttributes :: proc "c" (self: ^OpenGLPixelFormat, attribs: [^]OpenGLPixelFormatAttribute) -> ^OpenGLPixelFormat {
    return msgSend(^OpenGLPixelFormat, self, "initWithAttributes:", attribs)
}

@(objc_class="NSOpenGLView")
OpenGLView :: struct {using _: View }

@(objc_type=OpenGLView, objc_name="alloc", objc_is_class_method=true)
OpenGLView_alloc :: proc "c" () -> ^OpenGLView {
    return msgSend(^OpenGLView, OpenGLView, "alloc")
}

@(objc_type=OpenGLView, objc_name="initWithFrame")
OpenGLView_initWithFrame :: proc "c" (self: ^OpenGLView, frame_rect: Rect, pixel_format: ^OpenGLPixelFormat) -> ^OpenGLView {
    return msgSend(^OpenGLView, self, "initWithFrame:pixelFormat:", frame_rect, pixel_format)
}

@(objc_type=OpenGLView, objc_name="updateTrackingAreas")
OpenGLView_updateTrackingAreas :: proc "c" (self: ^OpenGLView) -> ^OpenGLView {
    return msgSend(^OpenGLView, self, "updateTrackingAreas")
}

@(objc_type=OpenGLView, objc_name="setWantsBestResolutionOpenGLSurface")
OpenGLView_setWantsBestResolutionOpenGLSurface :: proc "c" (self: ^OpenGLView, wantsHighRes: BOOL) {
    msgSend(nil, self, "setWantsBestResolutionOpenGLSurface:", wantsHighRes)
}

@(objc_class="NSOpenGLContext")
OpenGLContext :: struct {using _: Object}

@(objc_type=OpenGLView, objc_name="getOpenGLContext")
OpenGLView_getOpenGLContext :: proc "c" (self: ^OpenGLView) -> ^OpenGLContext {
    return msgSend(^OpenGLContext, self, "openGLContext")
}

@(objc_type=OpenGLContext, objc_name="setValues")
OpenGLContext_setValues :: proc "c" (self: ^OpenGLContext, swap_int: ^i32, param: Integer) {
    msgSend(nil, self, "setValues:forParameter:", swap_int, param)
}

@(objc_type=OpenGLContext, objc_name="makeCurrentContext")
OpenGLContext_makeCurrentContext :: proc "c" (self: ^OpenGLContext) -> ^OpenGLContext {
    return msgSend(^OpenGLContext, self, "makeCurrentContext")
}

@(objc_type=OpenGLContext, objc_name="flushBuffer")
OpenGLContext_flushBuffer :: proc "c" (self: ^OpenGLContext) {
    msgSend(nil, self, "flushBuffer")
}

foreign import dyld "system:c"
@(default_calling_convention="c", link_prefix="NS")
foreign dyld {
    LookupAndBindSymbol :: proc(name: cstring) -> rawptr ---
}

gl_set_proc_address :: proc (p: rawptr, name: cstring) {
	runtime.DEFAULT_TEMP_ALLOCATOR_TEMP_GUARD()

    mangled_name := fmt.ctprintf("_%s", name)
    (^rawptr)(p)^ = LookupAndBindSymbol(mangled_name)
}
