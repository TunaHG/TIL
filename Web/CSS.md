# CSS

## Usage

```css
@charset "UTF-8";
/* @import url("../subCss/basic.css") */
body {
    background-color: skyblue;
}
div.className {
    
}
div#idName {
    
}
.className ul li {
    
}
```

* `@import`를 통하여 다른 파일의 `CSS`를 가져와서 적용시킬 수 있다.

* `.className` : 특정 태그에서 선언된 class에 대해서 선언할 때 이용한다.
  
  * `div`와 같은 태그를 생략할 수 있다.
* `#idName` : 특정 태그에서 선언된 id에 대해서 선언할 때 사용한다.
* `.className ul li` : `className`라는 `class`를 가진 태그 내부에 있는 `ul`태그 내부의 `li`태그의 CSS를 지정해줄 때 사용한다.

* 선택자 다중 지정

  ```css
  body, h1, p {
      
  }
  ```

  * 여러개의 태그에 대한 CSS를 한번에 설정할 수 있다.

### 우선순위

> id > class > selector

* `<head>`에 선언되는`<style>`에서는 id의 우선순위가 가장 높으며 선택자의 우선순위가 가장 낮다.

> Selector > Inline > Link

* 선택자에 지정된 Style의 우선순위가 가장 높으며, `<head>`에서 `<style`>로 선언된 Inline이 둘째, `<link>`로 가져오는 외부 `CSS File`이 우선순위가 가장 낮다.

### In HTML

```html
<head>
    <link rel="stylesheet" href="../../CSS/Test.css" type="text/css">
</head>
```

* `link`로 `CSS File`을 호출해서 가져온다.

## Parameter

> 지정할 수 있는 수많은 Parameter가 있지만 자주 쓰거나, 유의해야할 것 몇개만 짚어본다.

* `margin` : 여백을 만들어주는 인자

  ```css
  margin: 100px 50px;
  ```

  * `top`, `right`, `bottom`, `left`순으로 선언되며 선언되지 않은 부분은 대칭된 부분의 값과 같다.
  * 하나의 값만 선언되면 모든 방향이 그 값으로 지정된다.
  * `px`단위는 생략될 수 있다. `px`가 아닌 `%`로 값을 지정할 수도 있다.
  * 혹은 `margin-bottom`처럼 각 방향을 언급한 `parameter`를 사용할 수 있다.
  * 맞붙은 두 태그의 `margin`이 중첩될경우 두 `margin`중 수치가 큰 것 하나만 적용된다.
    * 위 태그의 `margin-bottom`이 50이고 아래 태그의 `margin-top`이 100일 때 두 태그 사이의 `margin`은 150으로 적용되는 것이 아닌 큰 수치인 100으로 적용된다.

* `color`관련 인자에서 `rgba`
  
  * `(0, 0, 0, 0)`처럼 4개의 인자를 받는다. 앞의 세개는 r,g,b를 의미하며 0~255까지의 값을 가진다. 맨뒤의 값은 투명도를 의미하며 0~1까지의 값을 가진다.

* `transform` : 웹의 형태를 변환하는 인자
  * `-webkit-transform` : Chrome, Safari에 해당하는 `transform`
  * `-moz-transform` : Firefox에 해당하는 `transform`
  * `-ms-transform` : Explorer에 해당하는 `transform` 
  * 값으로 올 수 있는 형태 : `rotate`, `skew`, `scale`

* `*` : Asterisk, 모든 형식을 말함
* `*::`