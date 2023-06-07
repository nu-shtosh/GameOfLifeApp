# Game of Life

## Описание
Game of Life (Игра жизни) - это клеточный автомат, придуманный математиком Джоном Конвеем. Игра представляет собой модель эволюции популяции клеток на двумерной сетке. Каждая клетка может быть либо живой, либо мертвой. Эволюция происходит в виде последовательности поколений, где состояние каждой клетки зависит от состояния ее соседей.

## Правила
Правила игры очень просты:
1. Живая клетка, у которой меньше двух живых соседей, погибает от одиночества.
2. Живая клетка, у которой два или три живых соседа, выживает и продолжает жить.
3. Живая клетка, у которой больше трех живых соседей, погибает от перенаселения.
4. Мертвая клетка, у которой три живых соседа, оживает.

## Использование
1. Запустите приложение.
2. На стартовом экране можно ознакомиться с правилами, а при нажатиии "К модуляции" перейти к самой игре.
3. На экране будет отображена двумерная сетка клеток.
4. Касание каждой клетки переключает ее состояние между живым и мертвым.
5. Нажмите кнопку "Плэй", чтобы начать симуляции и увидеть, как клетки эволюционируют в соответствии с правилами игры.
6. Для управления скоростью эволюции используйте кнопки "Плюс" и "Минус".
7. Кнопка "Случайное заполнение" случайным образом заполняет сетку живыми клетками.
8. Кнопка "Очистить" очищает сетку и сбрасывает счетчик поколений.
9. При нажатии на кнопку "К легенде", можно ознакомится с основными фигурами из живых клеток которые могут встретиться в игре.

## Технологии
Игра разработана с использованием следующих технологий:
- SwiftUI - для построения пользовательского интерфейса.
- ObservableObject - для отслеживания изменений состояния игры.
