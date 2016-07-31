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

var Order = React.createClass({
  getInitialState: function() {
    return {
      cost: 0,
      products: this.props.products,
      selected_products: []
    };
  },

  handleCommentSubmit: function(e) {
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

    var total_price = products_for_consider.reduce(function(sum, current) {
      return sum + current;
    }, 0);

    this.setState({total: total_price});
  },

  render: function() {
    var total = 0;
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
        <div>Total Cost: {this.state.total}</div>
      </div>
    );
  }
});