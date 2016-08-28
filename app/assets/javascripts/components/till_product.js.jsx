class TillProduct extends React.Component {
  constructor(props) {
    super(props);
    this.selectHandler = this.selectHandler.bind(this);
  }

  selectHandler() {
    if (this.props.product.active === true) {
      store.dispatch({
        type: 'DESELECT_PRODUCT',
        product_id: this.props.product.id
      })
    } else {
      store.dispatch({
        type: 'SELECT_PRODUCT',
        product_id: this.props.product.id
      })
    }

  }

  render() {
    const product_styles = {
      product_count: {
        display: this.props.product.active ? null : 'none'
      }
    };
    return (

      <div className="product">

        <div className={this.props.product.active ? 'product-item-active' : 'product-item' }
             onClick={this.selectHandler}
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