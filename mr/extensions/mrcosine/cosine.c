// Include the Ruby headers and goodies
#include "ruby.h"
#include "math.h"

// Defining a space for information and references about the module to be stored internally
VALUE MRCosine;

// Prototype for the initialization method - Ruby calls this, not you
void Init_mrcosine();

// Prototype for our method 'cosine' - methods are prefixed by 'method_' here
VALUE method_cosine(VALUE self, VALUE array1, VALUE array2);

// The initialization method for this module
void Init_mrcosine() {
	MRCosine = rb_define_module("MRCosine");
	rb_define_method(MRCosine, "cosine", method_cosine, 2);
}

// The cosine method
VALUE method_cosine(VALUE self, VALUE array1, VALUE array2) {

	float dot_product, array1_normalized, array2_normalized, result;
	int i, array_size;

	array_size = RARRAY(array1)->len;

	// dot product
	dot_product = 0.;
	for(i=0; i < array_size; i++)
		dot_product += FIX2INT(rb_ary_entry(array1, i)) * FIX2INT(rb_ary_entry(array2, i));
	
	// normalized arrays
	array1_normalized = 0;
	array2_normalized = 0;
	for(i=0; i < array_size; i++) {
		array1_normalized += pow(FIX2INT(rb_ary_entry(array1, i)), 2);
		array2_normalized += pow(FIX2INT(rb_ary_entry(array2, i)), 2);
	}
	array1_normalized = sqrt(array1_normalized);
	array2_normalized = sqrt(array2_normalized);
	
	// cosine
	result = dot_product / (array1_normalized * array2_normalized);
	
	return rb_float_new(result);
}