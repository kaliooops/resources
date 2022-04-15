'use strict'

class Notification {
  constructor(options) {
    let element = document.createElement('div')
    element.className = 'notification'

    if (SETTINGS.lightMode === true) {
      element.classList.add('light-mode')
    }

    let icon

    function CreateIcon(name) {
      const icon = document.createElement('i')
      icon.className = `icon bi bi-${name}`
      element.appendChild(icon)
      return icon
    }

    if (options.icon) {
      icon = CreateIcon(options.icon)
    }

    if (options.type) {
      const type = options.type
      if (PRESETS[type] !== undefined) {
        if (!icon && PRESETS[type].icon && options.icon !== false) {
          icon = CreateIcon(PRESETS[type].icon)
          icon.style.color = PRESETS[options.type].primaryColor
        }
        if (SETTINGS.lightMode) {
          element.style.backgroundColor = PRESETS[options.type].lightMode.secondaryColor
          if (icon) {
            icon.style.color = PRESETS[options.type].lightMode.primaryColor
          }
        }
      }
    }

    let content = document.createElement('div')
    content.className = 'content'
    element.appendChild(content)

    let title = document.createElement('h4')
    title.className = 'title'
    title.textContent = options.title
    content.appendChild(title)

    function InsertParagraph(text) {
      let paragraph = document.createElement('p')
      paragraph.className = 'paragraph'
      paragraph.textContent = text
      content.appendChild(paragraph)
    }

    if (Array.isArray(options.message)) {
      for (let i = 0; i < options.message.length; i++) {
        InsertParagraph(options.message[i])
      }
    } else {
      InsertParagraph(options.message)
    }

    this.element = element
  }
}

let notifications = []

let container = {
  element: document.getElementById('container'),
  topOffset: 0
}

function Notify(options) {
  let notification = new Notification(options)

  notifications.unshift(notification)

  if (container.element == null) {
    container.element = document.createElement('div')
    container.element.id = 'container'
    document.body.appendChild(container.element)
  }
  container.topOffset = container.element.getBoundingClientRect().top

  container.element.appendChild(notification.element)

  anime({
    targets: notification.element,
    translateX: [window.innerWidth - notification.element.getBoundingClientRect().right + notification.element.offsetWidth, 0],
    easing: SETTINGS.easingStyle,
    duration: SETTINGS.slidingDuration,
    endDelay: SETTINGS.duration,
    direction: 'alternate',
    complete: function () {
      notifications.pop()

      if (notifications.length > 0) {
        const offset = notification.element.getBoundingClientRect().bottom - container.topOffset

        anime.remove(container.element)
        anime({
          targets: container.element,
          translateY: [offset, 0],
          easing: 'easeOutExpo',
          duration: 250
        })
      } else {
        container.element.remove()
        container.element = null
      }

      notification.element.remove()
    }
  })

  if (SETTINGS.sound) {
    const popSound = new Audio('media/pop.mp3')
    popSound.volume = .4
    popSound.play()
  }
}

