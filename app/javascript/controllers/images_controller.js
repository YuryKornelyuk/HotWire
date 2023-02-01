import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    // Добаляем таргет image из котрого достанем title для картинки
    static targets = ['image', 'title', 'save']
    static classes = ['loading']
    static values = {
        id: String
    }
    connect() {
        //Выводим подпись для картинки на лету
        const title = document.createElement('p')
        title.textContent = this.imageTarget.alt
        // Помечаем контент как редактируемый
        title.contentEditable = true
        // Маркируем элемент, чтобы в дальнейшем можно было обратиться к нему
        title.dataset.imagesTarget = 'title'
        // Добавляем событие для редактирования title
        title.dataset.action = 'click->images#editTitle'
        this.element.appendChild(title)
    }

    editTitle(e) {
        // Проверяем существует ли кнопка для сохранения
        if (!this.hasSaveTarget) {
            const btn = document.createElement('button')
            btn.textContent = 'Save'
            btn.classList = 'btn btn-primary btn-sm'
            // Маркируем кнопку для дальнейшей проверки существует она уже или нет
            btn.dataset.imagesTarget = 'save'
            // Добавляем событие для сохранения title
            btn.dataset.action = 'click->images#saveTitle'
            e.target.insertAdjacentElement('afterend', btn)
        }
    }

    async saveTitle(e) {
        e.preventDefault()
        // Добавляем класс дисейбл для кнопки
        e.target.disabled = true
        // Добавляем класс загрузки для title
        e.target.classList.add(this.loadingClass)

        const formData = new FormData()
        formData.append('image[title]', this.titleTarget.textContent)
        await this.doPatch(`/api/images/${this.idValue}`, formData)
        // Удаляем кнопку
        e.target.remove()
    }

    getUrl(e) {
        navigator.clipboard.writeText(e.target.src)
        // Порождаем событие copy, которое будет обработано контроллером toast_controller.js
        this.dispatch('copy', {detail: {content: 'Image URL copied to clipboard!'}})
    }

    async doPatch(url, body) {
        const csrfToken = document.getElementsByName('csrf-token')[0].content
        await fetch(url, {
            method: 'PATCH',
            body: body,
            headers: {
                "X-CSRF-Token": csrfToken,
            }
        })
    }
}