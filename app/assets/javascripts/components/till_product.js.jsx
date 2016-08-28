class TillProduct extends React.Component {
  render() {
    const product_styles = {
      product_count: {
        display: 'none'
      }
    };
    return (

      <div className="product">

        <div className="product-item"
        >
          <div>{this.props.product.title}</div>
          <div>{this.props.product.ml}ml / {this.props.product.price}₽</div>
        </div>

        <div className="product-count" style={product_styles.product_count}>
          <div className="remove">-</div>
          <div className="counter">1</div>
          <div className="add">+</div>
        </div>

      </div>

    );
  }
}