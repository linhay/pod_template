/// MIT License
///
/// Copyright (c) 2020 linhey
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.

/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.

import UIKit

open class SectionFlowLayout: UICollectionViewFlowLayout {

    public enum ContentMode {
        /// 左对齐
        case left
        /// header & footer 贴合 cell
        case headerAndFooterViewFitInset

        case none
    }

    public var contentMode = ContentMode.none

    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard let attributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() }) as? [UICollectionViewLayoutAttributes],

            let collectionView = collectionView else {
                return nil
        }

        switch contentMode {
        case .left:
            return modeLeft(collectionView: collectionView, attributes: attributes)
        case .none:
            return super.layoutAttributesForElements(in: rect)
        case .headerAndFooterViewFitInset:
            return modeHeaderAndFooterViewFitInset(collectionView: collectionView, attributes: attributes)
        }
    }

    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = self.collectionView, collectionView.bounds.size != newBounds.size else {
            return true
        }
        return false
    }

}

// MARK: - Mode
extension SectionFlowLayout {

    private func modeHeaderAndFooterViewFitInset(collectionView: UICollectionView, attributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes]? {
        for item in attributes {
            guard item.representedElementCategory == .supplementaryView,
                let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
                let inset = delegate.collectionView?(collectionView, layout: self, insetForSectionAt: item.indexPath.section)
                else {
                    continue
            }
            if item.representedElementKind == UICollectionView.elementKindSectionFooter {
                item.frame.origin.y -= inset.bottom
            } else if item.representedElementKind == UICollectionView.elementKindSectionHeader {
                item.frame.origin.y += inset.top
            }
        }
        return attributes
    }

    private func modeLeft(collectionView: UICollectionView, attributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes]? {
        var lineStore = [CGFloat: [UICollectionViewLayoutAttributes]]()
        var list = [UICollectionViewLayoutAttributes]()

        for item in attributes {
            guard item.representedElementCategory == .cell,
                let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
                /// self.minimumInteritemSpacing 获取时与 delegate 中数值不一致
                let minimumInteritemSpacing = delegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: item.indexPath.section) else {
                    list.append(item)
                    continue
            }

            if let lastItem = lineStore[item.frame.minY]?.last {
                item.frame.origin.x = lastItem.frame.maxX + minimumInteritemSpacing
                lineStore[item.frame.minY]?.append(item)
            } else {
                lineStore[item.frame.minY] = [item]
            }
            list.append(item)
        }
        return list
    }

}
