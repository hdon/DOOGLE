module doogle.drawing.image_def;
import doogle.drawing.image;
public import doogle.util.color : Color, Color3, Color4;
public import doogle.overloads.wrappers : InternalFormat;

shared class Image_Def {
	size_t width_;
	size_t height_;
	size_t depth_;
	InternalFormat format_;
	union {
		ubyte[] data_;
		Color[] colors_;

		Color3[] colors3_;
		Color4[] colors4_;
	}

	this() {
	}

	this(size_t _width, size_t _height, size_t _depth, InternalFormat _format, shared(ubyte[]) _data) {
		width_ = _width;
		height_ = _height;
		depth_ = _depth;
		format_ = _format;

		data_ = _data;
	}

	@property shared(float[]) float3A1() {
		shared(float[]) ret;
		foreach(c; colors3_) {
			ret ~= c.floats;
			ret ~= 1f;
		}
		return ret;
	}

	void opOpAssign(string s)(ubyte _data) {
		synchronized {
			static if (s =="~") {
				data_ ~= _data;
			}
		}
	}

	@property {
		size_t width() {
			synchronized {
				return width_;
			}
		}

		size_t height() {
			synchronized {
				return height_;
			}
		}

		size_t depth() {
			synchronized {
				return depth_;
			}
		}

		void width(size_t _width) {
			synchronized {
				width_ = _width;
			}
		}
		
		void height(size_t _height) {
			synchronized {
				height_ = _height;
			}
		}
		
		void depth(size_t _depth) {
			synchronized {
				depth_ = _depth;
			}
		}

		ref shared(Color3[]) colors3() {
			synchronized {
				return colors3_;
			}
		}

		ref shared(Color4[]) colors4() {
			synchronized {
				return colors4_;
			}
		}

		ref shared(Color[]) values() {
			synchronized {
				return colors_;
			}
		}

		ref shared(ubyte[]) data() {
			synchronized {
				return data_;
			}
		}

		ref InternalFormat format() {
			synchronized {
				return format_;
			}
		}

		void values(shared(Color[]) _colors) {
			synchronized {
				colors_ = _colors;
			}
		}

		void data(shared(ubyte[]) _data) {
			synchronized {
				data_ = _data;
			}
		}

		void format(InternalFormat _format) {
			synchronized {
				format_ = _format;
			}
		}
	}
}