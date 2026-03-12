# Image Generation

Generate images for courseware using Doubao Seedream API.

## When to Use

- Generating images for courseware content
- Creating visual aids, diagrams, illustrations
- When user asks to generate/create an image

## API Information

**Endpoint**: `https://ark.cn-beijing.volces.com/api/v3/images/generations`

**Model**: `doubao-seedream-5-0-260128`

**Auth**: Bearer token (stored in environment variable)

## Usage

### Environment Setup

Add to `.env` or set environment variable:

```bash
DOUBAO_IMAGE_API_KEY=your_api_key_here
```

### Quick Call

```bash
curl -X POST https://ark.cn-beijing.volces.com/api/v3/images/generations \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DOUBAO_IMAGE_API_KEY" \
  -d '{
    "model": "doubao-seedream-5-0-260128",
    "prompt": "Your image description in English",
    "sequential_image_generation": "disabled",
    "response_format": "url",
    "size": "2K",
    "stream": false,
    "watermark": true
  }'
```

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `model` | string | Fixed: `doubao-seedream-5-0-260128` |
| `prompt` | string | Image description (**English recommended**) |
| `size` | string | `2K` (2048x2048, minimum supported) |
| `response_format` | string | `url` (recommended) or `b64_json` |
| `watermark` | boolean | Add watermark (default: true) |
| `stream` | boolean | Stream response (default: false) |
| `sequential_image_generation` | string | `enabled` or `disabled` |

**Note**: The API requires minimum 3686400 pixels, so use `size: "2K"` (2048x2048).

### Response Format

```json
{
  "created": 1234567890,
  "data": [
    {
      "url": "https://..."
    }
  ]
}
```

## Prompt Writing Guide

### Structure

A good prompt includes:

1. **Subject** (主体): What to show
2. **Style** (风格): Art style, visual aesthetic
3. **Colors** (配色): Color scheme
4. **Details** (细节): Specific elements to include
5. **Mood/Atmosphere** (氛围): Emotional tone

### Style Keywords (Chinese)

**Diagram/Technical**:
- 扁平化设计, 信息图, 简洁风格
- 蓝灰配色, 科技感
- 流程图, 架构图, 示意图

**Illustration**:
- 插画风格, 卡通, 简约
- 柔和色调, 温暖

**Photo-realistic**:
- 写实, 真实质感, 电影质感
- 光线追踪, 景深, 高清

**Abstract**:
- 抽象, 概念图, 超现实
- 渐变, 几何图形

### Example Prompts

**Technical Diagram**:
```
一张展示Transformer架构中Self-Attention机制的信息图，扁平化设计风格，蓝白配色。
图中展示Query、Key、Value三个概念，用箭头表示数据流向。
中间展示注意力权重的计算过程，用不同粗细的连线表示权重大小。
整体风格简洁现代，适合技术博客配图，无文字标注。
```

**Concept Illustration**:
```
一个视觉隐喻图：展示"信息衰减"的概念。
左侧是一个完整的彩色图案，随着向右延伸，图案逐渐变得模糊、褪色、碎片化。
背景是深色，突出信息的"消失"感。
抽象风格，渐变色调，极简设计。
```

**Comparison Chart**:
```
左右对比图，展示RNN和Transformer的区别。
左侧：一串人排队传递物品，表示顺序处理，效率低。
右侧：一个中心节点同时连接所有外围节点，表示并行处理。
扁平化图标风格，蓝橙对比色，简洁明了。
```

## Workflow

1. **Read the image placeholder** from markdown: `【图：xxx】`
2. **Expand the description** into a detailed prompt
3. **Call the API** to generate image
4. **Download and save** image to `assets/images/` directory
5. **Update markdown** to use local image path

## File Naming Convention

```
{chapter}-{section}-{index}.png

Example:
01-02-tokenization.png
01-03-attention-mechanism.png
02-01-prompt-structure.png
```

## Script Helper

A helper script is available at `scripts/generate-image.sh`:

```bash
./scripts/generate-image.sh "your prompt here" output-filename
```

This will:
1. Call the API
2. Download the image
3. Save to `assets/images/{filename}.png`
4. Return the local path
