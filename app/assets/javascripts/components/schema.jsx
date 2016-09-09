const productSchema = new normalizr.Schema('product');

const arrayOfProducts = normalizr.arrayOf(productSchema);

const normalize = normalizr.normalize;