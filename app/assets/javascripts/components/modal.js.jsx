class Modal extends React.Component {

  constructor(props) {
    super(props);
    this.handleModel = this.handleModel.bind(this);
    this.state = {
      open: this.props.modal,
    };
  }

  handleModel() {
    this.props.handleModel({open: false, text: ''});
  }

  render() {
    const styles = {
      modal: {
        display: this.props.modal.open ? null : 'none',
        position: 'fixed',
        zIndex: 1,
        paddingTop: '100px',
        left: 0,
        top: 0,
        width: '100%',
        height: '100%',
        overflow: 'auto',
        backgroundColor: 'rgb(0,0,0)',
        backgroundColor: 'rgba(0,0,0,0.4)',
        cursor: 'pointer'
      },
      close: {
        color: 'white',
        float: 'right',
        fontSize: '28px',
        fontWeight: 'bold',
        cursor: 'pointer'
      },
      modalHeader: {
        padding: '2px 16px',
        backgroundColor: '#5cb85c',
        color: 'white',
        display: 'none'
      },
      modalBody: {
        padding: '2px 16px'
      },
      modalFooter: {
        padding: '2px 16px',
        backgroundColor: '#5cb85c',
        color: 'white',
        display: 'none'
      },
      modalContent: {
        position: 'relative',
        backgroundColor: '#E53A40',
        margin: 'auto',
        padding: 0,
        width: '80%',
        boxShadow: '0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19)'
      },
      modalText: {
        padding: '20px',
        display: 'flex',
        justifyContent: 'center',
        fontSize: '1.5rem',
        color: 'white'
      }
    };

    return (
      <div onClick={this.handleModel} style={styles.modal}>
        <div style={styles.modalContent}>
          <div style={styles.modalHeader}>
            <span onClick={this.handleModel} style={styles.close}>x</span>
            <h2>Modal Header</h2>
          </div>
          <div style={styles.modalBody}>
            <div style={styles.modalText}>{this.props.modal.text}</div>
          </div>
          <div style={styles.modalFooter}>
            <h3>Modal Footer</h3>
          </div>
        </div>
      </div>
    )
  }
}