var update = React.addons.update;


class Product extends React.Component {

  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.state = {done: 'product-item'};
  }

  handleChange (event) {
    this.setState({done: event.target.checked ? 'product-item-active' : 'product-item' });
    this.props.onCommentSubmit({id: this.props.id, state: event.target.checked});
  }

  render() {
    return (
      <div className={this.state.done}>
        <input type="checkbox"
               onChange={this.handleChange} />
        <div> {this.props.title} </div>
        <div> {this.props.price} </div>
      </div>
    );
  }
}

class Order extends React.Component {
  constructor(props) {
    super(props);
    this.handleCommentSubmit = this.handleCommentSubmit.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.state = {
      total: 0,
      products: this.props.products,
      selected_products: [],
      url: '/orders'
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
    console.log(selected_products);
    $.ajax({
      url: this.state.url,
      dataType: 'json',
      type: 'POST',
      data: {selected_products: selected_products, order: {cost_price: this.state.total} },
      success: function(data) {
        alert(`Совершена покупка на сумму: ${data.cost_price} руб.`)
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  render() {
    return (
      <div>
        <div>
          {
            this.state.products.map( function(product) {
              return <Product key={product.id}
                              id={product.id}
                              title={product.title}
                              price={product.price}
                              onCommentSubmit={this.handleCommentSubmit}

              />;
            }.bind(this))
          }
        </div>
        <div>
          <form onSubmit={this.handleSubmit}>
            <input type="submit" value="Post" disabled={this.state.total === 0 } />
          </form>
        </div>
        <div>Total Cost: {this.state.total}</div>
      </div>
    );
  }
}