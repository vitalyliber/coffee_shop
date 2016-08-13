var update = React.addons.update;


class Product extends React.Component {

  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.state = {
      done: 'product-item',
      checkbox_control: false
    };
  }

  handleChange (event) {
    if (this.state.done === 'product-item') {
      this.setState({done: 'product-item-active'});
      this.props.onCommentSubmit({id: this.props.id, state: true});
    } else {
      this.setState({done: 'product-item'});
      this.props.onCommentSubmit({id: this.props.id, state: false});
    }

  }

  componentWillUpdate() {
    if (this.props.checkbox_control === true) {
      this.setState({done: 'product-item'});
    }
  }

  render() {
    return (
      <div className={this.state.done}
           onClick={this.handleChange}
      >
        <div> {this.props.title} </div>
        <div> {this.props.price} руб.</div>
      </div>
    );
  }
}

class Order extends React.Component {
  constructor(props) {
    super(props);
    this.handleCommentSubmit = this.handleCommentSubmit.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleModel = this.handleModel.bind(this);
    this.state = {
      total: 0,
      products: this.props.products,
      selected_products: [],
      url: '/orders',
      checkbox_control: false,
      modal: false
    };
  }

  handleCommentSubmit (e) {
    if (e['state'] === true) {
      selected_products = update(this.state.selected_products, {$push: [e['id']] });
      this.setState({selected_products: selected_products });
    } else {
      selected_products = this.state.selected_products.filter( (x,i) => x != e['id'] );
      this.setState({selected_products: selected_products });
    }

    products_for_consider = this.state.products.
      filter( (product) => {
        return selected_products.some( (selected_product) =>
          selected_product == product.id
        );
      }).
      map( (product) => {
        return product.price;
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
      data: {selected_products: this.state.selected_products, order: {cost_price: this.state.total} },
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
                              checkbox_control={this.state.checkbox_control}
                              onCommentSubmit={this.handleCommentSubmit}

              />;
            }.bind(this))
          }
        </div>
        <div className="footer">
          <div className="container">
            <div className="elements">
              <h2 className="cost">СУММА: {this.state.total} руб.</h2>
              <div>
                <form onSubmit={this.handleSubmit}>
                  <input className="btn btn-primary" type="submit" value="КУПИТЬ" disabled={this.state.total === 0 } />
                </form>
              </div>
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