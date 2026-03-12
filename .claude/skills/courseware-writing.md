# Courseware Writing

Write engaging, accessible courseware content in Markdown format with visual placeholders.

## When to Use

- Creating course materials, lesson notes, or educational content
- Writing blog-style technical articles
- Developing training documentation
- Any long-form educational writing

## Writing Process

### Step 1: Outline First

**ALWAYS** write the outline before expanding into full content:

```markdown
## 大纲

1. 开篇引子（提出一个与读者息息相关的问题）
2. 核心要点一
3. 核心要点二
4. 核心要点三
5. 总结与思考题
```

### Step 2: Expand Section by Section

After outline approval, expand each section with full content.

### Step 3: Generate Images

After content is complete, generate images for all placeholders:

**Workflow:**
1. Collect all `【图：xxx】` placeholders from the document
2. Convert each description to a detailed English prompt
3. Call the image generation API
4. Download and save images to `assets/images/{chapter}-{index}.png`
5. Replace placeholders with actual image references

**Image Generation API:**
```bash
curl -X POST https://ark.cn-beijing.volces.com/api/v3/images/generations \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DOUBAO_IMAGE_API_KEY" \
  -d '{
    "model": "doubao-seedream-5-0-260128",
    "prompt": "Detailed English prompt here",
    "sequential_image_generation": "disabled",
    "response_format": "url",
    "size": "2K",
    "stream": false,
    "watermark": true
  }'
```

**Prompt Conversion Rules:**
- Translate Chinese description to English
- Add style keywords: "flat design", "infographic", "technical diagram"
- Add color scheme: "blue-gray color scheme", "modern and clean"
- Add purpose: "suitable for tech blog illustration"

## Format Requirements

### Markdown Structure

- Use `#` for article title (only once)
- Use `##` for main sections
- Use `###` for subsections
- Use **bold** for emphasis on key concepts
- Use `inline code` for technical terms

### Image Placeholders

When a visual aid is needed, use this exact format:

```markdown
【图：详细的图片描述，包括风格、内容、配色等】

Example:
【图：一张展示Transformer架构的信息图，采用扁平化设计风格，使用蓝白配色。图中左侧展示输入序列"我 爱 你"，中间是多层Transformer block，右侧展示输出。每个block内部标注Self-Attention和Feed Forward。箭头用虚线表示数据流向。整体风格简洁现代，适合技术博客配图。】
```

**Image description must include:**
- Subject matter (what to show)
- Visual style (flat, sketch, diagram, etc.)
- Color scheme
- Key elements to highlight
- Overall aesthetic goal

## Writing Style Guide

### Persona

扮演一位思维缜密、善于整合观点的写作者，为一家以简洁美学和深刻内容著称的热门在线出版平台撰写文章。

### Tone

- **简洁明了**：短段落，每段不超过3-4句
- **通俗易懂**：避免术语堆砌，必要时用类比
- **对话式**：像和朋友聊天，但保持专业
- **有深度**：不只概括，要分析"为什么重要"

### Article Structure

#### 1. Title

撰写一个吸引眼球、令人点击的标题。

```
Good: 为什么你的提示词总是不管用？LLM 注意力机制的真相
Bad: LLM 注意力机制介绍
```

#### 2. Opening (引言)

- 简短有力（2-3段）
- 提出一个与读者息息相关的问题或疑问
- 制造悬念，让读者想继续读下去

```markdown
你有没有想过：为什么同样的问题，ChatGPT 有时能完美回答，有时却答非所问？

更奇怪的是，你明明把所有背景信息都塞进去了，模型却好像"没看见"一样。

答案藏在 LLM 的注意力机制里——它决定了模型"看到"什么、"忽略"什么。理解这一点，你就能预测模型的行為，而不是被它的随机性搞得焦头烂额。
```

#### 3. Body (正文)

每个核心要点作为独立章节：

```markdown
## 要点一：注意力是有限的资源

【图：一个U型曲线图，展示"Lost in the Middle"现象。横轴是内容位置（开头、中间、结尾），纵轴是模型召回率。曲线两端高中间低。风格简洁，使用蓝色渐变。】

先说一个反直觉的事实：...

这不是 bug，而是...
```

**Each section should:**
- 有清晰醒目的小标题
- 用简短段落解释概念
- 提供"为什么这很重要"的分析
- 适时插入配图

#### 4. Closing (结尾)

- 简短而富有前瞻性的总结（1-2段）
- 留给读者一个发人深省的问题或值得深思的要点

```markdown
## 总结

注意力机制揭示了 LLM 的一个本质局限：它不是"理解"你的输入，而是"分配注意力"。

理解这一点，你就不会再把模型当成万能的神谕，而是一个需要精心设计输入的复杂工具。

**思考题**：如果你要设计一个系统来检测模型是否"注意到"了关键信息，你会怎么做？
```

## Content Principles

### Extract the Surprising

从资料中提炼出：
- 最令人惊讶的要点
- 最反直觉的发现
- 最具影响力的洞察

### Show, Don't Just Tell

```markdown
Bad: 幻觉是 LLM 的固有特性。

Good: 当你问 GPT-4 "谁是2024年世界杯冠军"时，它可能会一本正经地编造一个答案。这不是模型"撒谎"，而是概率生成的必然结果——它只是在预测最可能的下一个词，而不是查询事实数据库。
```

### Use Analogies

技术概念用日常类比来解释：

```markdown
Embedding 就像是给每个词发了一张"身份证"，上面记录了它的语义特征。"苹果"和"香蕉"的身份证很像（都是水果），而"苹果"和"汽车"的身份证差别很大。
```

## Image Generation Integration

This skill works with `image-generation` skill to create complete courseware with visuals.

### Automatic Image Generation

When writing courseware, use this workflow:

1. **Write content with placeholders:**
   ```markdown
   【图：一张展示Self-Attention机制的信息图，扁平化设计，蓝白配色】
   ```

2. **After content is complete, generate all images:**
   - Read all placeholders from the document
   - Convert to detailed English prompts
   - Call image generation API
   - Save to `assets/images/` directory
   - Update markdown with local paths

### Prompt Enhancement

Convert Chinese placeholder to English prompt:

| Chinese Placeholder | English Prompt |
|---------------------|----------------|
| 【图：RNN信息衰减示意图】 | "A diagram showing RNN information decay. A sequence of boxes from left to right, with color fading from bright blue to pale gray, representing information loss over sequence length. Flat design style, clean and minimal." |
| 【图：Transformer注意力机制】 | "A technical diagram showing Transformer self-attention mechanism. Three columns labeled Query, Key, Value. Arrows connecting them with varying thickness representing attention weights. Flat infographic style, blue-orange color scheme." |

### Image File Naming

```
assets/images/{lesson}-{sequence}-{description}.png

Examples:
assets/images/01-01-fill-blank-concept.png
assets/images/01-02-tokenization-comparison.png
assets/images/02-03-self-attention-mechanism.png
```

### Final Markdown Format

```markdown
![RNN信息衰减示意图](../../assets/images/02-01-rnn-decay.png)
```

---

## Checklist Before Submission

- [ ] 标题吸引眼球吗？
- [ ] 引言是否提出了一个与读者相关的问题？
- [ ] 每个章节有清晰的小标题吗？
- [ ] 段落简短易读吗？
- [ ] 配图描述是否详细？
- [ ] 结尾有思考题或发人深省的要点吗？
- [ ] 整体风格是否通俗易懂又有深度？

## Example Output Structure

```markdown
# 为什么你的提示词总是不管用？LLM 的注意力真相

你有没有想过：为什么同样的问题...

## 要点一：模型不是"读"你的输入

【图：xxx】

先说一个反直觉的事实...

## 要点二：注意力是稀缺资源

【图：xxx】

这带来了一个...

## 要点三：你可以"引导"注意力

【图：xxx】

好消息是...

## 总结

注意力机制揭示了...

**思考题**：...
```
