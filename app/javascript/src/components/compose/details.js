import React, { Component } from 'react';
import EmailTemplates from '../shared/templates';
import CardsService from '../../services/cards-service';

class Details extends Component {
  state = {
    template: this.props.card.body,
  }

  onSelectTemplate = ({ body }) => {
    const template = this.props.card.replaceAttributesForEmailTemplate(body);

    this.setState({ template });
  }

  onChange = (e) => {
    const { value, name } = e.target

    this.setState({
      [name]: value
    });
  }

  onSave = () => {
    const {
      props: { card: { id }, updateStatus },
      state: { template },
    } = this;

    const params = {
      card: {
        body: template
      }
    }

    CardsService.update(id, params).then(() => {
      updateStatus('ready')
    });
  }

  render() {
    const {
      props: { card: { email } },
      state: { template },
    } = this;

    return (
      <div className="details">
        <div className="email-body">
          <p>{email}</p>
          <textarea name="template" value={template} onChange={this.onChange} />
          <input onClick={this.onSave} type="submit" value="Save changes" />
        </div>
        <EmailTemplates onSelect={this.onSelectTemplate} />
      </div>
    )
  }
}

export default Details;