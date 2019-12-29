import React, { Component } from 'react';
import ContactsService from '../services/contacts-service';

import EmailTemplatesContext from '../contexts/email-templates-context';

import Contact from '../components/contacts/contact';
import ContactModal from '../components/contacts/contact-modal';
import EmailTemplatesService from '../services/email-templates-service';
import SearchInput from '../components/shared/search-input';

class Contacts extends Component {
  state = {
    page: 1,
    contacts: [],
    modalContactId: null,
    openModal: false,
  }

  componentDidMount() {
    const { page } = this.state;

    ContactsService.page(page).then(contacts => {
      this.setState({ contacts })
    });

    EmailTemplatesService.all().then(templates => {
      this.setState({ templates });
    })
  }

  openModal = (contactId) => {
    this.setState({
      openModal: true,
      modalContactId: contactId,
    })
  }

  closeModal = () => {
    const { modalContactId, contacts } = this.state;

    ContactsService.find(modalContactId).then(updatedContact => {
      const updatedContacts = contacts.map(contact => {
        if (updatedContact.id === contact.id) return updatedContact;
        return contact
      });

      this.setState({
        modalContactId: null,
        openModal: false,
        contacts: updatedContacts
      })
    });
  }

  search = (value) => {
    const { page } = this.state;

    ContactsService.search({ query: value, page }).then(contacts => {
      this.setState({ contacts })
    });
  }

  render() {
    const { contacts, modalContactId, openModal, templates } = this.state;

    return (
      <EmailTemplatesContext.Provider value={{templates}}>
        <div className="container contacts">
          { openModal ?
            <ContactModal
              contactId={modalContactId}
              closeModal={this.closeModal}
            /> : null
          }
          <div className="row">
            <div className="col-12">
              <h2>Contacts</h2>
            </div>
            <div className="col-12">
              <SearchInput onStopTyping={this.search} />
            </div>
            <div className="box row">
              {contacts.map(contact => (
                <Contact
                  {...contact}
                  key={contact.id}
                  openModal={this.openModal}
                />
              ))}
            </div>
          </div>
        </div>
      </EmailTemplatesContext.Provider>
    )
  }
}

export default Contacts;
