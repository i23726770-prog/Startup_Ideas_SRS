function addIdea() {
    const ideaInput = document.getElementById('ideaInput');
    const ideaText = ideaInput.value.trim();

    // Валидация
    if (ideaText === "") {
        alert('Введите название идеи!');
        return;
    }

    // Создаем новый элемент списка
    const ideaList = document.getElementById('ideaList');
    const li = document.createElement('li');
    
    // Кнопка удаления с подтверждением
    li.innerHTML = `
        <span>${ideaText}</span>
        <button onclick="if(confirm('Удалить идею?')) this.parentElement.remove()">Удалить</button>
    `;
    
    ideaList.appendChild(li);

    // Очищаем поле
    ideaInput.value = '';
    ideaInput.focus();
}
