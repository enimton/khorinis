## Khorinis — solid way to write Meteor applications

1. [Intro](#intro)
2. [Getting started](#getting-started)
3. [Concept](#concept)
4. [Project structure](#project-structure)
5. [How to write HTML](#how-to-write-html)
6. [How to write CSS](#how-to-write-css)
7. [How to write JS](#how-to-write-js)
8. [Block structure advices](#block-structure-advices)
9. [Tutorial](#tutorial)

## Caveats
- Khorinis is under development (though is pretty stable for use)
- Some documentation chapters may be unclear and poorly written

## Intro

#### What is Khorinis?

- Set of rules on how to write Meteor applications
- Meteor package

#### Why use Khorinis?

Khorinis provides solid rules on how to write Meteor applications. These rules guarantee that your code will be well-structured and easy-maintained.

Khorinis advises on how to structure project tree, how to name files and folders, how to separate server and client code, how to write templates, how to name CSS classes, how to write JS, and some other things.

## Getting started

#### Installation

Create empty Meteor project:

```
> meteor create myapp
> cd myapp
> rm myapp.js myapp.html myapp.css
```

And then add Khorinis package:

```
> meteor add imkost:khorinis
```

#### Initialization

For the first time you start Meteor, Khorinis will be initialized. After successful initialization, you will see this message in the console:

```
=> Khorinis was successfully initialized
=> Please start your app again
```

Then you need to run Meteor again.

During initialization process, `khorinis-adanos` package will be created. This package lives in `packages/khorinis-adanos` directory. You don't have to know anything about this package for now. Just don't remove it. We will discuss `khorinis-adanos` later.

#### Block, element, modifier

Khorinis is inspired by <a href="http://en.bem.info/method/definitions/">Yandex's BEM methodology</a>. It's not necessary to know about BEM, next chapters will provide all information you need.

## Concept

#### Every application is a set of blocks

Just blocks and nothing else. That's it. No models, views, controllers or other stuff. Only blocks.

Write application === Write all required blocks.

#### What is a block?

- Block is a logical unit of any application
- Block is a bunch of HTML, CSS and JS files

#### Workflow steps

Have an app idea => Write blocks => App is ready!

#### Example

Some base Blog application may be described by following blocks:

- **page** — provides `<head>` and `<body>`, manages layout
- **collections** — keeps mongo collections
- **postPreviews** — draws posts feed
- **postPreview** — draws post preview (used in posts feed)
- **postView** — draws full post
- **newPost** — draws new post form, provides functionality for writing posts
- **comments** — draws comments, provides commenting functionality

## Project structure

#### Project tree

```
myapp/
  _blocks/           <-- Exclude this folder from code editor
  packages/           
    khorinis-adanos/ <-- Exclude this folder from code editor
  private/
    blocks/          <-- Write application (i.e. blocks) here
      block1/
      block2/
      block3/
      ...
    khorinis-config.json
```

Any application is a set of blocks. Every block should live in its own folder inside `private/blocks` directory.

Wait a minute. Meteor ignores all files inside `private` folder, so how does it work, and what is `_blocks` directory, and what is `khorinis-config.json` file?

#### khorinis-adanos

`khorinis-adanos` package is a mini build tool that ships with Khorinis. The package provides this workflow:

1. You write blocks inside `private/blocks` directory
2. The package watches for file changes in `private/blocks`
3. Every time you do changes, `khorinis-adanos` "compiles" your blocks to `_blocks` folder
4. Then Meteor reads application from `_blocks` folder
5. That's how your application runs

You don't have to know anything about this compilation process. It just works, no configuration needed.

It's recommended to exclude `packages/khorinis-adanos` and `_blocks` directories from your code editor. Write blocks in `private/blocks` directory — that's all you need to know.

#### Why need compilation?

But why do we need compilation process at all? We can write blocks in root `blocks` folder, for example.

Point is that Khorinis doesn't follow Meteor's file load order rules and rules on separating client and server code. Also Khorinis brings features that couldn't be implemented without compilation step. We will discuss these features and Khorinis' rules in next chapters.

#### khorinis-config.json

`khorinis-config.json` is a file where you can configure some Khorinis options. Let's just leave it for now, we will discuss Khorinis configuration later.

#### Block structure

You can structure blocks in **simple way**:

```
someBlock/
  someBlock.css
  someBlock.html
  someBlock.js
```

Or split to **many files**:

```
someBlock/
  someBlock.css
  someBlock.html
  someBlock.helpers.js
  someBlock.feature1.js
  someBlock.feature2.js
  someBlock.feature3.js
```

Or even **add subdirectories**:

```
someBlock/
  css/
    someBlock.side-bar.css
    someBlock.content.css
    someBlock.item.css
  html/
    someBlock.html
    someBlock.parts.html
  js/
    server/
      someBlock.methods.js
    client/
      someBlock.helpers.js
      someBlock.js
```

It's up to you to decide how to structure blocks.

As it was previously said, Khorinis doesn't follow Meteor's file load order rules and rules on separating client and server code. Khorinis does not have any special folder names like Meteor does, so you can give any names to your files and subdirectories inside block.

#### How to name blocks

Every block has a name which should be unique for the application. By default convention blocks should be named in camelCase style, but you can use any style you want:

```
OK   : post_preview
OK   : PostPreview
OK   : post-preview
GOOD : postPreview
```

#### Speaking in short

- Write blocks in separate folders inside `private/blocks` directory
- Exclude `_blocks` and `packages/adanos` directories from your code editor

## How to write HTML

#### Block

```html
<!-- private/blocks/postPreview/postPreview.html -->
<template name="postPreview">
  <div class="postPreview">
    ...
  </div>
</template>
```

Name of block's `<template>` should be equal to the block's name. This template should include html-node (`<div>` or any other) which `class` also should be equal to block's name.

#### Elements

```html
<!-- private/blocks/postPreview/postPreview.html -->
<template name="postPreview">
  <div class="postPreview">

    <!-- This is element 'title' -->
    <h4 class="postPreview__title">
      {{title}}
    </h4>

    <!-- This is element 'body' -->
    <div class="postPreview__body">
      {{body}}
    </div>

    <!-- This is element 'createdAt' -->
    <div class="postPreview__createdAt">
      {{createdAt}}
    </div>

  </div>
</template>
```

Elements are just html-nodes (`<div>` or any other) inside block's `<template>`. These nodes need to have `class` attribute build by this rule: `<blockName>__<elementName>`.

#### How to name elements

Like blocks, elements are preferred to be named in camelCase. But you can use any name convention you want.

#### Elements inside elements in DOM tree

Sometimes you will need to place one element inside another element in DOM tree. This is allowed, but should be done right. Let's compare three versions of the same block `person`:

```html
<!-- BAD -->
<div class="person">
  <div class="person__address">

    <!-- `__` is used twice -->
    <div class="person__address__country">
      {{country}}
    </div>

  </div>
</div>
```

```html
<!-- OK -->
<div class="person">
  <div class="person__address">

    <!-- 'addressCountry' is ok -->
    <div class="person__addressCountry">
      {{country}}
    </div>

  </div>
</div>
```

```html
<!-- GOOD -->
<div class="person">
  <div class="person__address">

    <!-- 'country' is shorter then 'addressCountry' -->
    <div class="person__country">
      {{country}}
    </div>

  </div>
</div>
```

- Never name elements as "element of the element" (`person__address__country`).
- Always try to keep element names as short as possible. When you write `country` instead of `addressCountry` you don't lose any meaning, but `country` is shorter.

#### Templates for elements

When template for your block becomes heavy, it's recommended moving some elements to separate templates:

```html
<template name="gallery">
  <div class="gallery">
    <div class="gallery__title">
      {{title}}
    </div>
    <div class="gallery__description">
      {{description}}
    </div>
    <div class="gallery__images">
      {{#each images}}
        {{> galery__image image=this}}
      {{/each}}
    </div>
  </div>
</template>

<template name="gallery__image" input="image">
  <div class="gallery__image">
    <div class="gallery__imageTitle">
      {{image.title}}
    </div>
    <img src="gallery__imagePicture" src="{{image.url}}">
    <div class="gallery__imageDescription">
      {{image.description}}
    </div>
  </div>
</template>
```

You can keep `gallery__image` element at the same `gallery.html` file or move to another one, `gallery__image.html`, for instance.

#### Modifiers

Sometimes we need to create a block very similar to an existing one, but with a little bit different look or behaviour. Modifiers do this stuff.

A modifier is just an additional CSS class for block or element. By default, Khorinis uses double dash (`--`) to separate modifier:

```
<blockOrElem>--<modifier>
```

```css
.button--small { ... }
.button--big { ... }
.menu__item--active { ... }
```

Modifiers are also preferred to be in camelCase, but you can use any name convention.

Also Khorinis suggests dividing all of your modifiers into two groups: boolean and string:

```
<blockOrElem>--<mod>       <-- Boolean modifier
<blockOrElem>--<mod>-<val> <-- String modifier
```

```css
/* Boolean naming style */
.menu--tabs { ... }
.menu--list { ... }

/* String naming style */
.menu--layout-tabs { ... }
.menu--layout-list { ... }
```

You are free to decide which naming style to choose. But, for example, in the example above, string approach makes modifiers more meaningful.

That's how modifiers can be applied in real projects:

```html
<!-- private/blocks/menu/menu.html -->
<template name="menu" input="layout isDark">
  <div class="menu menu--layout-{{layout}} {{#if isDark}}menu--dark{{/if}}">
    <a class="menu__item" href="/">Main Page</a>
    <a class="menu__item" href="/about">About</a>
  </div>
</template>
```

```css
/* private/blocks/menu/menu.css */

/* Common styles */
.menu { ... }
.menu__item { ... }

/* Styles for list layout */
.menu--layout-list { ... }
.menu--layout-list .menu__item { ... }

/* Styles for tabs layout */
.menu--layout-tabs { ... }
.menu--layout-tabs .menu__item { ... }

/* Styles for dark menu */
.menu--dark { ... }
.menu--dark .menu__item { ... }
```

#### Class helper snippet

You must have been noticed that it's not convenient to write classes in this way:

```html
<div class="menu menu--layout-{{layout}} {{#if isDark}}menu--dark{{/if}}">
  ...
</div>
```

So you can write:

```html
<div {{class 'menu' layout=layout dark=isDark}}>
  ...
</div>
```

With this `class` helper:

```js
Template.registerHelper('class', function(className, params) {
  var mods = params.hash,
      classes = [ className ],
      modValue;

  for (modKey in mods) {
    modValue = mods[modKey];

    if (typeof modValue === 'boolean') {
      if (modValue) {
        classes.push(className + '--' + modKey);
      }
    } else {
      classes.push(className + '--' + modKey + '-' + modValue);
    }
  }

  return { class: classes.join(' ') };
});
```

#### Documenting templates

Complex templates can contain a lot of variables. Some of these variables are come from template helpers, some of them are global helpers, some of them are input data for template. It's hard to remember where particular data came from.

To make your templates easier to understand, Khorinis suggests to document your templates via template attributes like this:

```html
<template name="gallery" input="images">
  ...
</template>
```

Here we've said that `gallery` expects `images` variable on its input:

```
{{> gallery images=images}}
```

You can use space to separate several values in doc-attribute:

```html
<template name="gallery" input="images layout">
  ...
</template>
```

Template attributes are ignored by Meteor so they will not affect your templates, it's just a useful information for ourselves.

Basically, you may need only three doc-attributes:

- `input` — describes input data
- `helpers` — describes template helpers
- `this` — describes context of the template

But you can create your own doc-attributes and stick with them.

Let's see an example:

```html
<template name="gallery"
  input="images showPages layout"
  helpers="currentPage"
>
  <div {{class 'gallery' layout=layout}}>
    {{#if showPages}}
      <div class="gallery__currentPage">
        {{currentPage}}
      </div>
    {{/if}}
    {{#each images}}
      {{> gallery__image}}
    {{/each}}
  </div>
</template>

<template name="gallery__image" this="image">
  <!--
  Here we say that `this` should be treated
  as some `image` instance
  -->
  <img class="gallery__image" src="{{this.url}}">
</template>
```

Try to avoid using of `this` for data input. In the example above it would be better to write:

```html
{{#each images}}
  {{> gallery__image image=this}}
{{/each}}
```

#### Parts

Parts make easier to represent complex blocks. For instance, we have this complex block:

```html
<!-- private/blocks/messages/messages.html -->
<template name="messages">
  <div class="messages">
    {{#if currentUser}}
      {{#each messages}}
        <div class="messages__message">
          <div class="messages__senderName">
            {{this.senderName}}
          </div>
          <div class="messages__messageBody">
            {{this.text}}
          </div>
        </div>
      {{else}}
        <div class="messages__noMessages">
          Currently you have no messages
        </div>
        <button class="messages__writeMessage">
          Write message
        </button>
      {{/each}}
    {{else}}
      Please login to write messages<br>
      <div class="messages__login">
        {{> loginButton}}
      </div>
    {{/if}}
  </div>
</template>
```

A lot of code, hard to read, hard to understand. How can it be simplified?

**Approach 1:** move elements to separate templates:

```html
<!-- private/blocks/messages/messages.html -->
<template name="messages" helpers="messages">
  <div class="messages">
    {{#if currentUser}}
      {{#each messages}}
        {{> messages__message message=this}}
      {{else}}
        {{> messages__noMessages}}
        {{> messages__writeMessage}}
      {{/each}}
    {{else}}
      Please login to write messages<br>
      {{> messages__login}}
    {{/if}}
  </div>
</template>
```

It already looks better. But not good enough.

**Approach 2:** use parts

Part is like element, but part is not represented by some html-node with unique class. Part is just a container for anything: text, html, elements, other blocks, other parts.

Every part is a `<template>` with name build by this rule: `<blockName>_<partName>`.

Using parts, `messages` block can be written in this way:

```html
<!-- private/blocks/messages/messages.html -->
<template name="messages" helpers="messages">
  <div class="messages">
    {{#if currentUser}}
      {{#if messages}}
        {{> messages_default messages=messages}}
      {{else}}
        {{> messages_empty}}
      {{/if}}
    {{else}}
      {{> messages_login}}
    {{/if}}
  </div>
</template>

<template name="messages_default" input="messages">
  {{#each messages}}
    <div class="messages__message">
      <div class="messages__senderName">
        {{this.senderName}}
      </div>
      <div class="messages__messageBody">
        {{this.text}}
      </div>
    </div>
  {{/each}}
</template>

<template name="messages_empty">
  <div class="messages__noMessages">
    Currently you have no messages
  </div>
  <button class="messages__writeMessage">
    Write message
  </button>
</template>

<template name="messages_login">
  Please login to write messages<br>
  <div class="messages__login">
    {{> loginButton}}
  </div>
</template>
```

You can split your block to as many parts as you need. Parts can have their own template-data, helpers, events, but they should have no CSS (because they are not represented by any CSS class).

**Approach 3:** use parts, move logic to JS

Currently we have a lot of logic in `messages` template. It's OK, but we can move all of the logic to JS:

```html
<template name="messages" helpers="partTemplate">
  <div class="messages">
    {{> Tempalte.dynamic template=partTemplate}}
  </div>
</template>
```

```javascript
Template.messages.helpers({
  partTemplate: function() {
    if ( ! Meteor.user()) {
      return 'messages_login';
    }

    if (Messages.find().count() === 0) {
      return 'messages_empty';
    }

    return 'messages_default';
  }
});

Template.messages_default.helpers({
  messages: function() {
    return Messages.find();
  }
});
```

Now we have very simple template, three part templates for different cases, and all logic in JS.

## How to write CSS

#### Avoid nesting CSS rules

All of your blocks and element have unique CSS classes, so you don't have to use any nesting CSS rules to define styles for blocks and elements:

```css
/* BAD */
.block .block__elem1 { ... }
.block .block__elem2 { ... }

/* GOOD */
.block { ... }
.block__elem1 { ... }
.block__elem2 { ... }
```

Also it's not recommended using nesting CSS rules when some block is included into another block. It's better to use additional modifier or element:

```css
/* BAD */
.block1 .block2 { ... }

/* GOOD */
.block2--isInsideBlock1 { ... }

/* GOOD */
.block1__block2 { ... }
```

```html
<div class="block1__block2 block2">
  ...
</div>
```

Nesting rules are only acceptable for modifiers:

```css
.block { ... }
.block__elem { ... }

.block--mod { ... }
.block--mod .block__elem { ... }
```

#### Avoid ids

Blocks, elements, modifiers — all of them have unique classes, not ids, so don't use ids in your CSS too.

You can use ids in HTML if you really need them by some reason, but don't use ids for styling.

#### Don't apply CSS rules on tags

In Khorinis you should apply CSS rules only to classes. It's not recommended having styles which are applied to html-tags.

If you want some specific style for `<a/>` tag, then in regular situation you would create this CSS rule:

```css
a { ... }
```

But in Khorinis you need to create block `link`, create CSS style for this block, and add this block to every link:

```html
<!-- private/blocks/place/place.html -->
<template name="place" helpers="title url">
  <div class="place">
    <a class="place__title link" href="{{url}}">
      {{title}}
    </a>
  </div>
</template>
```

```css
/* private/blocks/link/link.css */
.link { ... }
```

You can see that block `link` is applied to `place__title` element. This is called mixing. You can mix some block with another block, you can mix some element with another element, and you can mix element with some block like in the example above.

#### Split CSS to separate files

Khorinis suggests to split every CSS instance (block, element, modifier) to separate file:

*OK:*

```css
/* private/blocks/someBlock/someBlock.css */
.someBlock { ... }
.someBlock__elem1 { ... }
.someBlock__elem2 { ... }
.someBlock--mod { ... }
.someBlock--mod .someBlock__elem1 { ... }
.someBlock--mod .someBlock__elem2 { ... }
```

*GOOD:*

```css
/* private/blocks/someBlock/someBlock.css */
.someBlock { ... }
```

```css
/* private/blocks/someBlock/elems/someBlock__elem1.css */
.someBlock__elem1 { ... }
```

```css
/* private/blocks/someBlock/elems/someBlock__elem2.css */
.someBlock__elem2 { ... }
```

```css
/* private/blocks/someBlock/mods/someBlock--mod.css */
.someBlock--mod { ... }
.someBlock--mod .someBlock__elem1 { ... }
.someBlock--mod .someBlock__elem2 { ... }
```

You can think that it's stupid to create so many files, but if you will follow this way, you will probably love it.

#### CSS files load order

Khorinis has its own rules on file load order. CSS files are loaded in this order:

1. Blocks' styles (`block.css`)
2. Elements' styles (`block__elem.css`)
3. Element modifiers' styles (`block__elem--mod.css`)
4. Block modifiers' styles (`block--mod.css`)

If you have this file structure:

```
myapp/
  private/
    blocks/
      header/
        elems/
          header__logo.css
          header__logo--big.css
        header.css
        header--small.css
      content/
        content.css
        content__tabs.css
```

Then file load order will be:

1. `content.css`
2. `header.css`
3. `content__tabs.css`
4. `header__logo.css`
5. `header__logo--big.css`
6. `header--small.css`

If you follow Khorinis' rules on how to write CSS, then you don't have to warry about file load order at all, because Khorinis' rules are logically right.

#### Delimiters configuration

You can configure delimiters for elements and modifiers in `private/khorinis-config.json` file. This file is automatically created when you first time start your application. It has very simple syntax:

```json
{
  "delimiters": {
    "elem": "__",
    "mod": "--"
  }
}
```

If you change elem delimiter to '-', for example, then `post-preview.css` will mean that this file describes element `preview` of block `post`, and will be loaded after all blocks, but before modifiers.

## How to write JS

#### Don't use Session, use ReactiveVar

When you use `Session`, you define global objects — not a good practice. Use [reactive-var](https://atmospherejs.com/meteor/reactive-var) package instead:

```
meteor add reactive-var
```

#### How to use ReactiveVar

Khorinis recommends prefix all reactive variables with `r`: `rCategory`, `rCurrentTab`, ...

```javascript
var rCategory = new ReactiveVar('initial value');

Tracker.autorun(function() {
  rCategory.get(); // <-- Reactive!
});

rCategory.set('main');
```

Is equivalent to:

```javascript
Session.set('category', 'initial value');

Tracker.autorun(function() {
  Session.get('category');
});

Session.set('category', 'main');
```

You can also use [reactive-dict](https://atmospherejs.com/meteor/reactive-dict) package.

#### k function

Khorinis provides only one function — `k`. This function registers _fragments_. The base syntax is:

```
k(fragmentName, action)
      |            |
   String       Function
```

#### What is a fragment?

Fragment is a logical unit of any application. Any block consists of fragments (in terms of JS). You can split blocks to as many fragments as you want. Nonetheless, it's always possible to describe any block with only one fragment. You can keep all block fragments in one file or in separate files.

#### Every fragment has a name

In the simplest case, fragment's name is equal to the block's name. But full formula for fragment name is:

```
Fragment Name = <blockName>[.<fragment-description>]
```

Fragment description is something that explains what this specific fragment does. You can use any characters in fragment description, but it's recommended sticking with dots (`.`), dashes (`-`), underscores (`_`), any digits (`0-9`) and any letters (`a-z`, `A-Z`).

These are valid fragment names:

- `previewBlock`
- `previewBlock.helpers`
- `previewBlock.helpers-and-events`
- `posts._removePost`
- `newPost.Manage_submit`
- `person.--Animate-on-scrolling`

#### Fragment example

```javascript
// private/blocks/profile/profile.js
k('profile', function() {

  Template.profile.helpers({
    fullName: function() {
      return this.firstName + ' ' + this.lastName;
    }
  });

});
```

Here we've registered `profile` fragment. This is a very simple example, it does not use any fragment-related-features. So actually you can omit fragment definition:

```javascript
// private/blocks/profile/profile.js
Template.profile.helpers({
  fullName: function() {
    return this.firstName + ' ' + this.lastName;
  }
});
```

But it's a good practice to wrap all of your code to fragments.

#### Fragment features

Now let's learn what fragments do.

There is a global object `blocks` (actually it's not global, but let's imagine it is). This object keeps all of your blocks. Any block is a JS object too. When you register fragment via `k` function, you create a field at `blocks`:

```javascript
// blocks === {}

k('foo', function() {});

// blocks === { foo: {} }
```

Inside fragment `this` refers to current block object. So you can do:

```javascript
// blocks === {}

k('foo', function() {
  this.bar = 'baz';
});

// blocks === { foo: { bar: 'baz' } }
```

That's how you create fields and methods for your blocks. But how one block can use fields and methods of another block? You can think of something like this:

```javascript
// private/blocks/collections/collections.js
k('collections', function() {
  this.Posts = new Mongo.Collection('posts');
});


// private/blocks/postPreviews/postPreviews.js
k('postPreviews', function() {
  Posts = blocks.collections.Posts; // <-- use `Posts` from `collections` block

  Template.postPreviews.helpers({
    posts: function() {
      return Posts.find();
    }
  });
});
```

But there is no global variable `blocks`, remember? We imagined it to be global just to understand the concept. To use fields and methods of other blocks you need to know about extended syntax of `k` function.

#### Extended k syntax

```
k(fragmentName[, dependencies...], action)
      |                |             |
   String           String        Function
```

Three dots (...) mean that can be any number of arguments: from 0 to infinity.

#### How to use fields and methods of other blocks

```javascript
// private/blocks/collections/collections.js
k('collections', function() {
  this.Posts = new Mongo.Collection('posts');
});


// private/blocks/postPreviews/postPreviews.js
k('postPreviews'
, 'collections.Posts' // <-- use `Posts` from `collections` block
, function(Posts) { // <-- `collections.Posts` will be accecible via `Posts` variable

  Template.postPreviews.helpers({
    posts: function() {
      return Posts.find();
    }
  });

});
```

You can use as many fields and methods as you need:

```javascript
// private/blocks/collections/collections.js
k('collections', function() {
  this.Posts = new Mongo.Collection('posts');
  this.Tags = new Mongo.Collection('tags');
  this.Ratings = new Mongo.Collection('ratings');
});


// private/blocks/postPreviews/postPreviews.js
k('postPreviews'
, 'collections.Posts'   // <-- use `Posts`   from `collections` block
, 'collections.Tags'    // <-- use `Tags`    from `collections` block
, 'collections.Ratings' // <-- use `Ratings` from `collections` block
, function(Posts, Tags, Ratings) {
  // ...
});
```

And you don't have to warry about file load order:

```javascript
// private/blocks/postPreviews/postPreviews.js
k('postPreviews'
, 'collections.Posts'
, 'collections.Tags'
, 'collections.Ratings'
, function(Posts, Tags, Ratings) {
  // ...
});


// private/blocks/collections/collections.Posts-and-Tags.js
k('collections.Posts-and-Tags', function() {
  this.Posts = new Mongo.Collection('posts');
  this.Tags = new Mongo.Collection('tags');
});


// private/blocks/collections/collections.Ratings.js
k('collections.Ratings', function() {
  this.Ratings = new Mongo.Collection('ratings');
});
```

Khorinis is smart enough to understand that in this case fragments should be executed in this order:

1. `collections.Posts-and-Tags`
2. `collections.Ratings`
3. `postPreviews`

Khorinis prevents fragment execution until all fragment dependencies are defined.

#### Private fields and methods

If you need to create fields and methods that should not be used by other blocks, then just prefix them with `_`:

```javascript
// private/blocks/tabs/tabs.js
k('tabs', function() {
  this._rCurrentTab = new ReactiveVar(0);
});


// private/blocks/tabs/tabs.helpers.js
K('tabs.helpers'
, 'tabs._rCurrentTab'
, function(rCurrentTab) {

  Template.tabs.helpers({
    currentTab: function() {
      return rCurrentTab.get();
    }
  });

});


// private/blocks/tabs/tabs.events.js
k('tabs.events'
, 'tabs._rCurrentTab'
, function(rCurrentTab) {

  Template.tabs.events({
    'click .tabs__tab': function() {
      rCurrentTab.set(this.index);
    }
  });
  
});
```

Here `_rCurrentTab` is prefixed with `_` and it means that this variable should not be used by other blocks. But if you really need to use it in another block, you can do it.

#### Benefits of using fragments

- No global variables at all (just `k` function)
- You don't need to warry about fragments load order

#### How to separate client and server code

By default, Khorinis serves all files to **client only**. To change locus of the file you need to use Khorinis-instructions. Instruction is a **zero-indent comment** written by this pattern:

```javascript
// :: <instruction>
```

For `coffeescript` you should write:

```coffeescript
# :: <instruction>
```

There are three instructions you can use:

- `client`
- `server`
- `client-server`

To make server-only file, you need to add `server` instruction before the code:

```javascript
// :: server
k('collections', function() {
  // This fragment will be served to server only
});
```

To make shared file, you need to add `client-server` instruction:

```javascript
// :: client-server
k('collections', function() {
  // This fragment will be served to both: client and server
});
```

You don't need to add `client` instruction to make client-only file, because all files are served to client by default.

#### Several instructions in one file

Instructions are even more powerfull. You can describe client and server code just in one file:

```javascript
// blocks/previews/previews.js
// :: client
k('previews', function() {
  // Client code for previews block
});

// :: server
k ('previews', function() {
  // Server code for previews block
});
```

## Block structure advices

#### HTML files

Keep blocks, elements and parts in separate files:

```
audioPlayer.html

autioPlayer_default.html

audioPlayer__positionLine.html
audioPlayer__volumeLine.html
```

#### CSS files

Keep blocks, elements and modifiers in separate files:

```
audioPlayer.css

audioPlayer--paused.css

audioPlayer--version-light.css
audioPlayer--version-pro.css

audioPlayer__button.css
audioPlayer__button--disabled.css

audioPlayer__controls.css
```

#### JS files

Keep every fragment in separate file, divide all fragments into two groups:

1. Preparation
2. Tasks

Preparation fragments define fields and methods:

```
audioPlayer.pause.js          <-- defines `pause` method
audioPlayer.play.js           <-- defines `play` method
audioPlayer._playNext.js      <-- defines `_playNext` method
audioPlayer.rCurrentAudio.js  <-- defines `rCurrentAudio` field
```

Also you can create base preparation fragment where you can describe some base fields and methods (or all fields and methods):

```
audioPlayer.js
```

To define several methods/fields in one file, devide their names by single dash (`-`):

```
audioPlayer.play-pause.js  <-- defines `play` and `pause` methods
```

Task fragments don't define any fields and methods, they do some tasks. Task fragments should be named in this way:

```
<block>.--<Task-description>.js
```

Task description should be human-readable, begin with uppercased letter, words should be separated by single dash (`-`):

```
audioPlayer.--Audio-upload.js        <-- provides audio upload functionality
audioPlayer.--Keyboard-shortcuts.js  <-- provides keyboard shortcuts
```

Tasks just bring some functionality. When you remove some task, then feature provided by this task shoud disappear, and everythnig else should keep working.

#### Subfolders

- Keep elements at `elems` subfolder
- Keep modifiers at `mods` subfolder
- Keep parts at `parts` subfolder
- Keep frag at `fragments` subfolder
- Keep the rest at root

```
audioPlayer/
  mods/
    audioPlayer--paused.css
    audioPlayer--size-l.css
    audioPlayer--size-m.css
    audioPlayer--size-s.css
    audioPlayer--version-light.css
    audioPlayer--version-pro.css
  elems/
    audioPlayer__button.css
    audioPlayer__controls.css
    audioPlayer__controls.html
    audioPlayer__pause.css
    audioPlayer__play.css
    audioPlayer__playNext.css
    audioPlayer__playPrev.css
    audioPlayer__positionLine.css
    audioPlayer__positionLine.html
    audioPlayer__volumeLine.css
    audioPlayer__volumeLine.html
  parts/
    audioPlayer_brokenAudio.html
    audioPlayer_default.html
  fragments/
    audioPlayer.--Audio-upload.js
    audioPlayer.--Controls-clicks.js
    audioPlayer.--Keyboard-shortcuts.js
    audioPlayer.--Manage-broken-audio.js
    audioPlayer.--Position-change.js
    audioPlayer.--Version-switch.js
    audioPlayer.--Volume-change.js
    audioPlayer.getPosition-setPosition.js
    audioPlayer.getVolume-setVolume.js
    audioPlayer.pause.js
    audioPlayer.play.js
    audioPlayer.playNext.js
    audioPlayer.playPrev.js
    audioPlayer.setTrack.js
  audioPlayer.css
  audioPlayer.html
  audioPlayer.js
```

#### Create your own rules

Khorinis gives you a freedom on how to structure blocks. So if you invent some rules that are more convenient for you, then use them.

## Tutorial

*Tutorial is under development*

Tutorial will be available on separate website, and will describe how to build non-trivial web application using Meteor and Khorinis.
