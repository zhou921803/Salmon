
/**
 * 创建枚举，枚举值从0 开始
 */
export default function Enum() {
    for (var i in arguments) {
        this[arguments[i]] = Number(i);
    }
}