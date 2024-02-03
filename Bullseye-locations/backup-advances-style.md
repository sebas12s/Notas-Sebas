# Back ups de Advances Style

## Fox block / icf-construction

[Link](<[text](https://foxblocksadmin.bullseyelocations-staging.com/local/icf-construction)>)

```html
<style></style>

<script>
  console.log('test');
  var searchContainer = () => {
    let formGroup = document.createElement('div');

    formGroup.classList.add('form-group');
    formGroup.classList.add('search-form-group');

    let cityContainer = document.querySelector(
      '.filterPanel_postalCodeContainer'
    );

    if (cityContainer) {
      let cityInput = document.querySelector('#postalCode');
      cityInput.classList.remove('rounded-1');
      cityInput.classList.remove('my-2');
      cityContainer.classList.add('search-block');
    }
    const keywordContainer = document.querySelector(
      '.filterPanel_keywordContainer'
    );
    if (keywordContainer) {
      document.querySelector('#keyword').classList.remove('form-control-sm');
    }

    let labels = Array.from(document.getElementsByTagName('label') || []);
    labels.forEach((label) => {
      label.classList.remove('mb-1');
    });

    const secondRow = document.querySelector('.filterPanel__secondaryRow');
    if (secondRow) {
      secondRow && secondRow.remove();
    }
  };

  var isAdvisor = false;

  // Locations Container
  var getLocationContainers = () => {
    const locationItemContainer = document.querySelectorAll(
      '.locationItem_container'
    );

    const allLocationsContainer = document.querySelector(
      '.listmaplocator__container'
    );

    var advisorsContainer = document.createElement('div');
    advisorsContainer.classList.add('advisors-container');
    advisorsContainer.classList.add('mr-2');
    advisorsContainer.classList.add('w-100');

    allLocationsContainer.prepend(advisorsContainer);

    locationItemContainer.forEach((container) => {
      container.classList.remove('flex-column');
      const locationInformationContainer = container.querySelector(
        '.locationInformation__container'
      );
      locationInformationContainer.classList.remove('flex-md-row');
      locationInformationContainer.classList.remove('d-flex');

      const addressContainer = container.querySelector(
        '.locationInformation__addressContainer'
      );
      const locationBadge = container.querySelector(
        '.locationInformation__locationTypeContainer'
      );

      const address = Array.from(
        container.getElementsByTagName('address') || []
      );
      if (address) {
        address.forEach((element) => {
          const country = element.querySelector('span[data-name="country"]');
          country && country.remove();

          if (locationBadge) {
            locationBadge.innerText != 'null'
              ? element.append(locationBadge)
              : (isAdvisor = true);
            var locationTooltip = document.createElement('div');
            locationTooltip.classList.add('location-tooltip');
            locationTooltip.innerHTML = `<div>
          <p><strong>Platinum</strong> - Stocks Product (High Volume), Bracing for Rent, Completes Estimates/Take-offs, Provides Jobsite Support/Assistance</p>
          <p><strong>Gold</strong> - Stocks Product, Bracing for Rent, Completes Estimates/Take-offs</p>
          <p><strong>Silver</strong> - Stocks Some Product</p>
          <p><strong>Bronze</strong> - Non Stocking</p> 
        </div>`;
            locationBadge.append(locationTooltip);
            locationBadge.addEventListener('mouseenter', (e) => {
              console.log(e.target.querySelector('location-tooltip'));
              e.target.querySelector('.location-tooltip').style.display =
                'block';
            });
            locationBadge.addEventListener('mouseleave', (e) => {
              e.target.querySelector('.location-tooltip').style.display =
                'none';
            });
          }
        });
      }

      const spans = Array.from(container.getElementsByTagName('span') || []);
      if (spans) {
        spans.forEach((span) => {
          let spanText = span.textContent.trim().toLowerCase();
          if (spanText === 'directions') {
            span.style.display = 'block';
          }
          if (spanText === 'view phone number') {
            span.style.display = 'block';
            span.innerText = 'Call';
          }
          if (spanText === 'website') {
            span.style.display = 'block';
          }
        });
      }

      const businessHours = container.querySelector(
        '.locationItem__businessHoursContainer'
      );
      businessHours && addressContainer.append(businessHours);

      let serviceInfoDiv;
      let hasServiceArea = false;
      let locationAttribute = container.querySelector(
        "[name='locationAttribute']"
      );

      if (locationAttribute) {
        const locationAttributes = JSON.parse(locationAttribute.value);
        locationAttributes.forEach((attribute) => {
          if (
            attribute.AttributeId === 4074 &&
            attribute.AttributeValue.length > 0
          ) {
            serviceInfoDiv = `<div class='service-area'><strong>Service Area: </strong>${attribute.AttributeValue}</strong></div>`;
            hasServiceArea = true;
          }
        });

        if (hasServiceArea || isAdvisor) {
          const serviceInfoContainer = document.createElement('div');
          serviceInfoContainer.classList.add('serviceInfo__container');
          serviceInfoContainer.innerHTML = serviceInfoDiv;
          addressContainer.append(serviceInfoContainer);
          advisorsContainer.append(container.parentElement);
          container.parentElement.classList.add('advisor');
        }
      }

      var locationRightColumn = container.querySelector(
        '.locationItem__infoContainer'
      );

      if (locationRightColumn) {
        locationRightColumn.classList.add('location-right-column');
        locationRightColumn.classList.remove('d-flex');
      }
      distanceContainer = container.querySelector(
        '.locationInformation__distanceContainer'
      );
      const profileButtonContainer = container.querySelector(
        '.locationItem__moreInfoContainer'
      );

      // Advisors treatment
      if (container.parentElement.classList.contains('advisor')) {
        const profileButtonHREF =
          profileButtonContainer.firstElementChild.getAttribute('href');

        distanceContainer.remove();
        profileButtonContainer.remove();

        const locationInformationContainer = container.querySelector(
          '.locationInformation__addressContainer'
        );
        locationRightColumn.prepend(locationInformationContainer);

        const directionsButton = container.querySelector(
          '.locationInformation__directionsButton'
        );
        directionsButton.remove();

        const linksContainer = container.querySelector(
          '.locationInformation__buttonsContainer'
        );

        const viewProfileLink = document.createElement('a');
        viewProfileLink.classList.add('advisor__link');
        viewProfileLink.setAttribute('target', '_top');
        profileButtonHREF &&
          viewProfileLink.setAttribute('href', profileButtonHREF);
        viewProfileLink.innerText = 'View Profile';

        const emailButtonHREF = container.querySelector(
          '.locationInformation__emailButton'
        );

        let emailHref;
        if (emailButtonHREF) {
          emailHref = emailButtonHREF.firstElementChild.getAttribute('href');
          container.querySelector('.locationInformation__emailButton').remove();
        }

        const emailLink = document.createElement('a');
        emailLink.classList.add('advisor__link');
        emailButtonHREF && emailLink.setAttribute('href', emailHref);
        emailLink.innerText = 'Email';

        const phoneButtonHREF = container
          .querySelector('.locationInformation__phoneButton')
          .firstElementChild.getAttribute('href');

        container.querySelector('.locationInformation__phoneButton').remove();

        const phoneLink = document.createElement('a');
        phoneLink.classList.add('advisor__link');
        phoneLink.classList.add('advisor__link__phone');
        phoneButtonHREF && phoneLink.setAttribute('href', phoneButtonHREF);
        phoneLink.innerText = 'View Phone';

        const pipeSeparator =
          '<span class="advisor__link_separator"> | </span>';

        linksContainer.prepend(phoneLink);
        linksContainer.prepend(emailLink);
        emailLink.insertAdjacentHTML('afterEnd', pipeSeparator);
        linksContainer.prepend(viewProfileLink);
        viewProfileLink.insertAdjacentHTML('afterEnd', pipeSeparator);

        const advisorPhone = container.querySelector('.advisor__link__phone');

        if (advisorPhone) {
          advisorPhone.addEventListener('click', (e) => {
            if (e.target.innerText.includes('View')) {
              e.stopImmediatePropagation();
              e.preventDefault();
              const text = e.target.innerText;
              const number = e.target.href;
              e.target.innerText = number.slice(4);
            }
          });
        }

        const serviceAreaContainer = container.querySelector(
          '.serviceInfo__container'
        );
        const locationItemContainer = container.querySelector(
          '.locationItem_container'
        );
        container.append(serviceAreaContainer);
      } else {
        locationRightColumn.prepend(distanceContainer);
      }

      const locationInformationButton = container.querySelector(
        '.locationInformation__moreInfoButton'
      );

      locationInformationButton &&
        locationInformationButton.classList.add('profile-button');

      const locationItemLeadButton = container.querySelector(
        '.locationItem__leadButton'
      );
      locationItemLeadButton &&
        locationItemLeadButton
          .getElementsByTagName('button')[0]
          .classList.remove('rounded-1');
    });
  };

  // City List Specific
  window.cityPagesLoaded = () => {
    console.log('test 2');
    const locationItemContainer = document.querySelectorAll(
      '.locationItem_container'
    );

    locationItemContainer.forEach((container) => {
      let spans = Array.from(container.getElementsByTagName('span') || []);
      if (spans) {
        spans.forEach((span) => {
          let spanText = span.textContent.trim().toLowerCase();
          if (spanText === 'view phone number') {
            span.style.display = 'block';
            span.innerText = 'Call';
          }
          if (spanText === 'website') {
            span.style.display = 'block';
            span.closest('div').classList.add('location-button');
          }
        });
      }

      const profileButtonContainer = container.querySelector(
        '.locationItem__moreInfoContainer'
      );
      const profileButton = profileButtonContainer.querySelector('.btn');
      profileButton &&
        profileButton.closest('.btn').classList.add('profile-button');

      const locationItemLeadButton = container.querySelector(
        '.locationItem__leadButton'
      );
      locationItemLeadButton &&
        locationItemLeadButton
          .getElementsByTagName('button')[0]
          .classList.remove('rounded-1');
    });
  };

  // Local Page Specific
  if (window.location.pathname.toLowerCase().includes('/local/')) {
    const locationInformationContainer = document.querySelectorAll(
      '.locationInformation__addressContainer'
    );
    locationInformationContainer.forEach((container) => {
      let spans = Array.from(container.getElementsByTagName('span') || []);
      if (spans) {
        spans.forEach((span) => {
          let spanText = span.textContent.trim().toLowerCase();
          if (spanText === 'view phone number') {
            span.style.display = 'block';
            span.innerText = 'Call';
          }
        });
      }
    });
  }

  window.filterPanelLoaded = () => {
    const selectElement = document.querySelector('#countryId');

    selectElement.addEventListener('change', function () {
      searchContainer();
    });
  };

  window.mapListLocatorLoaded = () => {
    //setTimeout(() => {
    getLocationContainers();
    // },1200);
  };

  // Obtener las entradas de navegación
  var navigationEntries = performance.getEntriesByType('navigation');

  // Obtener la entrada más reciente
  var lastNavigationEntry = navigationEntries[navigationEntries.length - 1];

  // Verificar si la entrada es un reload
  if (lastNavigationEntry.type === 'reload') {
    console.log('Se ha realizado una recarga de la página');
  } else {
    console.log('No se ha realizado una recarga de la página');
  }

  const fixHeader = () => {
    // Select the elements with the class "citypages__container"
    var containers = document.querySelectorAll('.citypages__container');

    // Loop through each container
    containers.forEach(function (container) {
      // Select the first child node
      var firstNode = container.firstElementChild;

      // Add the inline style to the first node
      firstNode.style.position = 'fixed';
      firstNode.style.left = '0';
      firstNode.style.right = '0';
      firstNode.style.top = '0';
    });
  };

  try {
    setTimeout(() => {
      // display none by default in advanced styles css
      const isCityPages = document.querySelector('.citypages__container');
      if (window !== window.parent) {
        const customHeaderClass = document.querySelector(
          '.custom-header-class'
        );
        customHeaderClass?.remove();
      }

      if (isCityPages) {
        fixHeader();

        // Seleccionar los elementos <a> dentro del contenedor
        var links = document.querySelectorAll('.citylist__country-container a');

        // Agregar un evento de clic a cada enlace
        links.forEach(function (link) {
          link.addEventListener('click', function () {
            fixHeader();
          });
        });
      }
    }, 150);
  } catch (error) {
    console.error(error);
  }

  /* window.cityListLoaded = () => {
 // Seleccionar el elemento con la clase "citypages__container"
var container = document.querySelector('.citypages__container');

// Obtener el segundo nodo hijo del contenedor
var secondNode = container.children[1];

// Crear 5 elementos <br />
for (var i = 0; i < 5; i++) {
  var brElement = document.createElement('br');
  
  // Insertar el elemento <br /> después del segundo nodo
  container.insertBefore(brElement, secondNode.nextSibling);
}
    
 }*/

  // Seleccionar el elemento con la clase "citypages__container"
  var container = document.querySelector('.citypages__container');

  // Crear una función de callback para el observador
  var observerCallback = function (mutationsList, observer) {
    mutationsList.forEach(function (mutation) {
      // Verificar si se agregó un nodo al principio del contenedor
      if (
        mutation.type === 'childList' &&
        mutation.addedNodes.length > 0 &&
        mutation.previousSibling === null
      ) {
        // Ocultar el primer nodo
        fixHeader();
      }
    });
  };

  // Crear un observador utilizando la clase MutationObserver
  var observer = new MutationObserver(observerCallback);

  // Configurar el observador para que observe cambios en los hijos del contenedor
  var observerConfig = { childList: true };

  // Iniciar la observación del contenedor
  observer.observe(document, {
    attributes: true,
    childList: true,
    subtree: true,
  });
</script>
```
