class TillProduct extends React.Component {
  constructor(props) {
    super(props);
    this.selectHandler = this.selectHandler.bind(this);
    this.addHandler = this.addHandler.bind(this);
    this.removeHandler = this.removeHandler.bind(this);
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

  addHandler() {
    store.dispatch({
      type: 'ADD_REPEAT',
      product_id: this.props.product.id
    })
  }

  removeHandler () {
    store.dispatch({
      type: 'REMOVE_REPEAT',
      product_id: this.props.product.id
    })
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
          <div>{this.props.product.ml} {this.props.product.meter} / {this.props.product.price}₽</div>
        </div>

        <div className="product-count" style={product_styles.product_count}>
          <div className="remove" onClick={this.removeHandler}>-</div>
          <div className="counter">{this.props.product.repeat}</div>
          <div className="add" onClick={this.addHandler}>+</div>
        </div>

      </div>

    );
  }
}