---
title: 团队页面
titleTemplate: VitePress 教程
---

# 团队页面

如果您想介绍您的团队，您可以使用团队组件来构造团队页面。有两种使用这些组件的方法。

1. 是将其嵌入文档页面
2. 是创建一个完整的团队页面

## 在页面中显示团队成员

您可以使用 `vitepress/theme` 中公开的组件 `<VPTeamMembers>` ，在任何页面上显示团队成员列表。

```vue
<script setup>
    import { VPTeamMembers } from 'vitepress/theme';

    const members = [
        {
            avatar: 'https://foruda.gitee.com/avatar/1676904596461741689/146486_linjialiang_1578919498.png!avatar100',
            name: '地上马',
            title: '文章作者',
            links: [{ icon: 'github', link: 'https://github.com/linjialiang' }],
        },
        {
            avatar: 'https://www.github.com/yyx990803.png',
            name: 'Evan You',
            title: 'VitePress 创始人',
            links: [{ icon: 'github', link: 'https://github.com/linjialiang' }],
        },
    ];
</script>

<VPTeamMembers size="small" :members="members" />
```

::: details 上面将在卡片查找元素中显示团队成员。它应该显示类似于下面的内容。

<script setup>
import { VPTeamMembers } from "vitepress/theme";

const members = [
  {
    avatar:
      "https://foruda.gitee.com/avatar/1676904596461741689/146486_linjialiang_1578919498.png!avatar100",
    name: "地上马",
    title: "文章作者",
    links: [{ icon: "github", link: "https://github.com/linjialiang" }],
  },
  {
    avatar: "https://www.github.com/yyx990803.png",
    name: "Evan You",
    title: "VitePress 创始人",
    links: [{ icon: "github", link: "https://github.com/linjialiang" }],
  },
];
</script>

<VPTeamMembers size="small" :members="members" />

:::

`<VPTeamMembers>` 组件有 2 种不同尺寸，`small` 和 `medium`。虽然它归结为您的偏好，但通常 `small` 大小应该更适合当使用在文档页面。

此外，您可以添加更多的属性，例如添加“描述”或“赞助商”按钮。了解更多关于 [`<VPTeamMembers>`](#vpteammembers)。

在文档页面中嵌入团队成员对于小型团队来说是很好的，因为拥有专用的完整团队页面可能太多，或者引入部分成员作为文档上下文的参考。

如果您有大量的成员，或者只是想有更多的空间来显示团队成员，请考虑 [创建一个完整的团队页面](#full-team)。

## 创建完整的团队页面 {#full-team}

您也可以创建完整的团队页面，而不是将团队成员添加到文档页面，类似于创建自定义主页的方式。

要创建团队页面，首先，创建一个新的 `md` 文件。文件名无关紧要，但在这里我们称之为 `team.md`。在此文件中，设置 `frontmatter` 选项 `layout: page`，然后您可以使用 `TeamPage` 组件组成页面结构。

```html
---
layout: page
---

<script setup>
    import { VPTeamPage, VPTeamPageTitle, VPTeamMembers } from 'vitepress/theme';

    const members = [
        {
            avatar: 'https://foruda.gitee.com/avatar/1676904596461741689/146486_linjialiang_1578919498.png!avatar100',
            name: '地上马',
            title: '文章作者',
            links: [{ icon: 'github', link: 'https://github.com/linjialiang' }],
        },
        // ...
    ];
</script>

<VPTeamPage>
    <VPTeamPageTitle>
        <template #title> Our Team </template>
        <template #lead>
            The development of VitePress is guided by an international team, some of whom have chosen to be featured
            below.
        </template>
    </VPTeamPageTitle>
    <VPTeamMembers :members="members" />
</VPTeamPage>
```

当创建完整的团队页面时，请记住用 `<VPTeamPage>` 组件包装所有组件。此组件将确保所有嵌套的团队相关组件获得正确的布局结构，如：间距。

`<VPPageTitle>` 组件添加页面标题部分。标题是`<h1>`标题。使用 `#title` 和 `#lead` 插槽记录您的团队。

`<VPMembers>` 的工作原理与在文档页面中使用时相同。它将显示成员列表。

## 添加分区以划分团队成员

您可以在团队页面中添加“章节”。例如，您可能有不同类型的团队成员，如核心团队成员和社区合作伙伴。您可以将这些成员划分为多个部分，以便更好地解释每个组的角色。

为此，将`<VPTeamPageSection>`组件添加到我们之前创建的 `team.md` 文件中。

```html
---
layout: page
---

<script setup>
    import { VPTeamPage, VPTeamPageTitle, VPTeamMembers, VPTeamPageSection } from 'vitepress/theme';

    const coreMembers = [
        // ...
    ];
    const partners = [
        // ...
    ];
</script>

<VPTeamPage>
    <VPTeamPageTitle>
        <template #title>Our Team</template>
        <template #lead>...</template>
    </VPTeamPageTitle>
    <VPTeamMembers size="medium" :members="coreMembers" />
    <VPTeamPageSection>
        <template #title>Partners</template>
        <template #lead>...</template>
        <template #members>
            <VPTeamMembers size="small" :members="partners" />
        </template>
    </VPTeamPageSection>
</VPTeamPage>
```

`<VPTeamPageSection>` 组件具有与 `<VPTeamPageTitle>` 组件类似的 `#title` 和 `#lead` 插槽，以及用于显示团队成员的 `#members` 插槽。

记住将 `#members` 插槽放入 `<VPTeamMembers>` 组件中。

## `<VPTeamMembers>`

`<VPTeamMembers>`组件显示给定的成员列表。

::: code-group

```html [案例]
<VPTeamMembers
    size="medium"
    :members="[
    { avatar: '...', name: '...' },
    { avatar: '...', name: '...' },
    ...
  ]" />
```

```ts [结构]
interface Props {
    // Size of each members. Defaults to `medium`.
    size?: 'small' | 'medium';

    // List of members to display.
    members: TeamMember[];
}

interface TeamMember {
    // Avatar image for the member.
    avatar: string;

    // Name of the member.
    name: string;

    // Title to be shown below member's name.
    // e.g. Developer, Software Engineer, etc.
    title?: string;

    // Organization that the member belongs.
    org?: string;

    // URL for the organization.
    orgLink?: string;

    // Description for the member.
    desc?: string;

    // Social links. e.g. GitHub, Twitter, etc. You may pass in
    // the Social Links object here.
    // See: https://vitepress.dev/reference/default-theme-config.html#sociallinks
    links?: SocialLink[];

    // URL for the sponsor page for the member.
    sponsor?: string;
}
```

:::

## `<VPTeamPage>`

创建完整团队页面时的根组件。它只接受一个插槽。它将样式化所有传入的与团队相关的组件。

## `<VPTeamPageTitle>`

添加页面的“标题”部分。最好在开始时使用 `<VPTeamPage>`。它接受 `#title` 和 `#lead` 插槽。

```html
<VPTeamPage>
    <VPTeamPageTitle>
        <template #title> Our Team </template>
        <template #lead>
            The development of VitePress is guided by an international team, some of whom have chosen to be featured
            below.
        </template>
    </VPTeamPageTitle>
</VPTeamPage>
```

## `<VPTeamPageSection>`

在团队页面中创建一个“节”。它接受 `#title`、`#lead` 和 `#members` 插槽。您可以在 `<VPTeamPage>` 中添加任意多个部分。

```html
<VPTeamPage>
    <!-- ... -->
    <VPTeamPageSection>
        <template #title>Partners</template>
        <template #lead>Lorem ipsum...</template>
        <template #members>
            <VPTeamMembers :members="data" />
        </template>
    </VPTeamPageSection>
</VPTeamPage>
```
