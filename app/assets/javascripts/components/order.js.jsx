var update = React.addons.update;


class Product extends React.Component {

  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.addRepeat = this.addRepeat.bind(this);
    this.removeRepeat = this.removeRepeat.bind(this);
    this.handleOnOffCountPanel = this.handleOnOffCountPanel.bind(this);
    this.state = {
      done: 'product-item',
      checkbox_control: false,
      count_panel: false,
      repeat: 1
    };
  }

  handleChange (event) {
    if (this.state.done === 'product-item') {
      this.setState({done: 'product-item-active'});
      this.setState({count_panel: true});
      this.props.onProductSelection({id: this.props.id, state: true});
    } else {
      this.setState({done: 'product-item'});
      this.setState({count_panel: false});
      this.props.onProductSelection({id: this.props.id, state: false});
    }
    this.handleOnOffCountPanel()
  }

  handleOnOffCountPanel () {
    this.props.onRepeat({repeat: 1, id: this.props.id});
    this.setState({repeat: 1});
  }

  addRepeat () {
    repeat = this.state.repeat + 1;
    this.setState({repeat: repeat});
    this.props.onRepeat({repeat: repeat, id: this.props.id});
  }

  removeRepeat () {
    if (this.state.repeat !== 1) {
      repeat = this.state.repeat - 1;
      this.setState({repeat: repeat});
      this.props.onRepeat({repeat: repeat, id: this.props.id});
    }
  }

  componentWillUpdate() {
    if (this.props.checkbox_control === true) {
      this.setState({done: 'product-item'});
      this.handleOnOffCountPanel();
      this.setState({count_panel: false});
    }
  }

  render() {
    const product_styles = {
      product_count: {
        display: this.state.count_panel ? null : 'none'
      }
    };
    return (
      <div className="product">

        <div className={this.state.done}
             onClick={this.handleChange}
        >
          <div> {this.props.title} </div>
          <div>{this.props.ml}ml / {this.props.price}₽</div>
        </div>

        <div className="product-count" style={product_styles.product_count}>
          <div className="remove" onClick={this.removeRepeat}>-</div>
          <div className="counter">{this.state.repeat}</div>
          <div className="add" onClick={this.addRepeat}>+</div>
        </div>

      </div>

    );
  }
}

class Order extends React.Component {
  constructor(props) {
    super(props);
    this.handleProductSelection = this.handleProductSelection.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleModel = this.handleModel.bind(this);
    this.handleRepeat = this.handleRepeat.bind(this);
    this.handleProductsConsider = this.handleProductsConsider.bind(this);
    this.state = {
      total: 0,
      products: this.props.products,
      selected_products: [],
      url: '/orders',
      checkbox_control: false,
      modal: false,
      repeat_products: []
    };
    repeat_products = []
  }

  handleProductSelection (e) {
    if (e['state'] === true) {
      selected_products = update(this.state.selected_products, {$push: [e['id']] });
      this.setState({selected_products: selected_products });
    } else {
      selected_products = this.state.selected_products.filter( (x,i) => x != e['id'] );
      this.setState({selected_products: selected_products });
    }

    this.handleProductsConsider()
  }

  handleProductsConsider () {
    products_for_consider = this.state.products.
    filter( (product) => {
      return selected_products.some( (selected_product) =>
        selected_product == product.id
      );
    }).
    map( (product) => {
      repeat_product = repeat_products.filter( function (repeat_product) {
        return repeat_product.id === product.id
      })[0];

      if (typeof repeat_product === 'object') {
        return product.price * repeat_product.repeat;
      } else {
        return product.price;
      }

    });

    var total_price = products_for_consider.reduce((sum, current) => {
      return sum + current;
    }, 0);

    this.setState({total: total_price});
  }

  handleSubmit (products) {
    products.preventDefault();
    console.log(this.state.selected_products);
    $.ajax({
      url: this.state.url,
      dataType: 'json',
      type: 'POST',
      data: {
        selected_products: this.state.selected_products,
        repeat_products: JSON.stringify(this.state.repeat_products),
        order: {
          cost_price:
          this.state.total,
          point_id: this.props.point.id}
      },
      success: function(data) {
        this.setState({checkbox_control: true});
        this.setState({selected_products: []});
        this.setState({total: 0});
        this.setState({modal: {open: true, text: `Покупка на сумму: ${data.cost_price} руб.`}});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
        this.setState({modal: {open: true, text: `Ошибка: ${this.props.url} ${status} ${err.toString()}`}});
      }.bind(this)
    });
  }

  handleRepeat (r) {
    repeat_product = this.state.repeat_products.filter( function (product) {
        if (product.id === r.id) {
          return true
        } else {
          return false
        }
      }
    )[0];

    if (repeat_product) {
      repeat_products = this.state.repeat_products.map( function(product) {

        if (product.id === r.id) {
          return {id: product.id, repeat: r.repeat}
        } else {
          return {id: product.id, repeat: product.repeat}
        }

      });

    } else {
      repeat_products = update(this.state.repeat_products, {$push: [{id: r['id'], repeat: r.repeat}] });
    }

    this.setState({repeat_products: repeat_products});

    this.handleProductsConsider()
  }

  handleModel (m) {
    this.setState({modal: m.open, text: ''});
  }

  componentDidUpdate() {
    if (this.state.checkbox_control !== false) {
      this.setState({checkbox_control: false});
    }
  }

  render() {
    return (
      <div>
        <div className="container">
          {
            this.state.products.map( function(product) {
              return <Product key={product.id}
                              id={product.id}
                              title={product.title}
                              price={product.price}
                              ml={product.ml}
                              checkbox_control={this.state.checkbox_control}
                              onProductSelection={this.handleProductSelection}
                              onRepeat={this.handleRepeat}

              />;
            }.bind(this))
          }
        </div>
        <div className="footer">
          <div className="container">
            <div className="elements">
              <button onClick={this.handleSubmit} disabled={this.state.total === 0 } className="cost btn btn-primary">{this.state.total} ₽</button>
            </div>
          </div>

        </div>

        <Modal
          modal={this.state.modal}
          handleModel={this.handleModel}
        />
      </div>
    );
  }
}