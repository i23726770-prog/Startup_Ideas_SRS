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
        <div>
            <button onclick="editIdea(this.previousElementSibling)">Ред.</button>
            <button onclick="if(confirm('Удалить идею?')) this.parentElement.parentElement.remove()">Удалить</button>
        </div>
    `;
    
    ideaList.appendChild(li);

    // Очищаем поле
    ideaInput.value = '';
    ideaInput.focus();
    
    function editIdea(spanElement) {
    const currentText = spanElement.innerText;
    const newText = prompt('Редактировать идею:', currentText);
    
    if (newText !== null && newText.trim() !== "") {
        spanElement.innerText = newText.trim();
    }
}
}
